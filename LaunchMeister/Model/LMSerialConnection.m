#import "LMSerialConnection.h"
#import "LMSerialConnectionDelegate.h"

@interface LMSerialConnection ()
{
    int serialFileDescriptor; // file handle to the serial port
    bool readThreadRunning;
    struct termios gOriginalTTYAttrs; // Hold the original termios attributes so we can reset them on quit ( best practice )
}
@end

@implementation LMSerialConnection
@synthesize delegate = _delegate;

- (id)init
{
    self = [super init];
    if (self)
    {

        serialFileDescriptor = -1;
        readThreadRunning = FALSE;

        NSString *result = [self openSerialPort:@"/dev/cu.usbmodem12341" baud:(speed_t) 9600];

        if (result == nil)
        {
            NSLog(@"Serial connection established");
            [self.delegate connectionEstablished];
            [self performSelectorInBackground:@selector(incomingTextUpdateThread:) withObject:[NSThread currentThread]];
        } else
        {
            NSLog(@"Error: starting serial connection: %@", result);
            [self.delegate connectionFailed];
        }
    }

    return self;
}

- (NSString *)openSerialPort:(NSString *)serialPortFile baud:(speed_t)baudRate
{
    int success;

    // close the port if it is already open
    if (serialFileDescriptor != -1)
    {
        close(serialFileDescriptor);
        serialFileDescriptor = -1;

        // wait for the reading thread to die
        while (readThreadRunning);

        // re-opening the same port REALLY fast will fail spectacularly... better to sleep a sec
        sleep(0.5);
    }

    // c-string path to serial-port file
    const char *bsdPath = [serialPortFile cStringUsingEncoding:NSUTF8StringEncoding];

    // Hold the original termios attributes we are setting
    struct termios options;

    // receive latency ( in microseconds )
    unsigned long mics = 3;

    // error message string
    NSString *errorMessage = nil;

    // open the port
    //     O_NONBLOCK causes the port to open without any delay (we'll block with another call)
    serialFileDescriptor = open(bsdPath, O_RDWR | O_NOCTTY | O_NONBLOCK);

    if (serialFileDescriptor == -1)
    {
        // check if the port opened correctly
        errorMessage = @"Error: couldn't open serial port";
    } else
    {
        // TIOCEXCL causes blocking of non-root processes on this serial-port
        success = ioctl(serialFileDescriptor, TIOCEXCL);
        if (success == -1)
        {
            errorMessage = @"Error: couldn't obtain lock on serial port";
        } else
        {
            success = fcntl(serialFileDescriptor, F_SETFL, 0);
            if (success == -1)
            {
                // clear the O_NONBLOCK flag; all calls from here on out are blocking for non-root processes
                errorMessage = @"Error: couldn't obtain lock on serial port";
            } else
            {
                // Get the current options and save them so we can restore the default settings later.
                success = tcgetattr(serialFileDescriptor, &gOriginalTTYAttrs);
                if (success == -1)
                {
                    errorMessage = @"Error: couldn't get serial attributes";
                } else
                {
                    // copy the old termios settings into the current
                    //   you want to do this so that you get all the control characters assigned
                    options = gOriginalTTYAttrs;

                    /*
                          cfmakeraw(&options) is equivilent to:
                          options->c_iflag &= ~(IGNBRK | BRKINT | PARMRK | ISTRIP | INLCR | IGNCR | ICRNL | IXON);
                          options->c_oflag &= ~OPOST;
                          options->c_lflag &= ~(ECHO | ECHONL | ICANON | ISIG | IEXTEN);
                          options->c_cflag &= ~(CSIZE | PARENB);
                          options->c_cflag |= CS8;
                          */
                    cfmakeraw(&options);

                    // set tty attributes (raw-mode in this case)
                    success = tcsetattr(serialFileDescriptor, TCSANOW, &options);
                    if (success == -1)
                    {
                        errorMessage = @"Error: coudln't set serial attributes";
                    } else
                    {
                        // Set baud rate (any arbitrary baud rate can be set this way)
                        success = ioctl(serialFileDescriptor, IOSSIOSPEED, &baudRate);
                        if (success == -1)
                        {
                            errorMessage = @"Error: Baud Rate out of bounds";
                        } else
                        {
                            // Set the receive latency (a.k.a. don't wait to buffer data)
                            success = ioctl(serialFileDescriptor, IOSSDATALAT, &mics);
                            if (success == -1)
                            {
                                errorMessage = @"Error: coudln't set serial latency";
                            }
                        }
                    }
                }
            }
        }
    }

    // make sure the port is closed if a problem happens
    if ((serialFileDescriptor != -1) && (errorMessage != nil))
    {
        close(serialFileDescriptor);
        serialFileDescriptor = -1;
    }

    return errorMessage;
}

// updates the textarea for incoming text by appending text
- (void)appendToIncomingText:(id)text
{
    NSAttributedString *attrString = [[NSMutableAttributedString alloc] initWithString:text];

    NSString *input = [attrString string];
    NSString *trimmedString = [input stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];

    [self.delegate didReceiveSignal:trimmedString];
}

// This selector/function will be called as another thread...
//  this thread will read from the serial port and exits when the port is closed
- (void)incomingTextUpdateThread:(NSThread *)parentThread
{


    // mark that the thread is running
    readThreadRunning = TRUE;

    const int BUFFER_SIZE = 100;
    char byte_buffer[BUFFER_SIZE]; // buffer for holding incoming data
    int numBytes = 0; // number of bytes read during read
    NSString *text; // incoming text from the serial port

    // assign a high priority to this thread
    [NSThread setThreadPriority:1.0];

    // this will loop unitl the serial port closes
    while (TRUE)
    {
        // read() blocks until some data is available or the port is closed
        numBytes = read(serialFileDescriptor, byte_buffer, BUFFER_SIZE); // read up to the size of the buffer
        if (numBytes > 0)
        {
            // create an NSString from the incoming bytes (the bytes aren't null terminated)
            text = [NSString stringWithCString:byte_buffer length:numBytes];

            // this text can't be directly sent to the text area from this thread
            //  BUT, we can call a selector on the main thread.
            [self performSelectorOnMainThread:@selector(appendToIncomingText:)
                                   withObject:text
                                waitUntilDone:YES];
        } else
        {
            break; // Stop the thread if there is an error
        }
    }

    // make sure the serial port is closed
    if (serialFileDescriptor != -1)
    {
        close(serialFileDescriptor);
        serialFileDescriptor = -1;
    }

    // mark that the thread has quit
    readThreadRunning = FALSE;

    // give back the pool
}
@end