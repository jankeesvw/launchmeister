//
//  TTDropAreaViewController.m
//  LaunchMeister
//
//  Created by Jankees Woezik on 15-04-12.
//  Copyright (c) 2012 Twelve Twenty. All rights reserved.
//

#import "LMLaunchPadController.h"
#import "LMLaunchPad.h"

@implementation LMLaunchPadController
{
}

@synthesize image;
@synthesize title;
@synthesize dropArea;
@synthesize selectedFile = _selectedFile;
@synthesize address = _address;

- (void)loadView
{
    [super loadView];
    self.dropArea.delegate = self;
}


- (void)awakeFromNib
{
    [super awakeFromNib];
    [self setSelectedFile:self.selectedFile];
}

- (void)setSelectedFile:(NSURL *)aSelectedFile
{
    _selectedFile = aSelectedFile;

    if ([_selectedFile path])
    {
        NSImage *imageFromURL = [[NSWorkspace sharedWorkspace] iconForFile:[_selectedFile path]];

        [imageFromURL setSize:NSMakeSize(128, 128)];
        self.image.image = imageFromURL;

        self.title.stringValue = [[self.selectedFile path] lastPathComponent];
    } else
    {
        self.image.image = [[NSImage alloc] init];
        self.title.stringValue = @"Drop a file";
    }
}

- (void)fileDropped:(NSURL *)url
{
    self.selectedFile = url;
}

- (IBAction)launchApp:(id)sender
{
    if (![[self.selectedFile path] isEqualToString:@""])
    {
        NSUserNotification *notification = [[NSUserNotification alloc] init];

        if ([[self.selectedFile pathExtension] isEqual:@"sh"])
        {
            NSMutableString *executionPath = [NSMutableString stringWithString:@"/"];
            NSArray *components = [self.selectedFile pathComponents];

            for (int i = 0; i < components.count - 1; i++)
            {
                NSString *component = [components objectAtIndex:i];

                if (![component isEqualToString:@"/"])
                {
                    [executionPath appendFormat:@"%@/", component];
                }
            }

            [executionPath appendFormat:@"./%@", [components lastObject]];

            NSString *theScript = [NSString stringWithFormat:@"tell application \"Terminal\"\n"
                                                                     "\tactivate\n"
                                                                     "\tdo script \"%@ \"\n"
                                                                     "end tell", executionPath];

            notification.title = @"Running script in terminal";
            notification.informativeText = [self.selectedFile path];

            NSAppleScript *script = [[NSAppleScript alloc] initWithSource:theScript];
            [script executeAndReturnError:nil];
        } else
        {
            notification.title = @"Launching application";
            notification.informativeText = [[self.selectedFile path] lastPathComponent];

            [[NSWorkspace sharedWorkspace] launchApplication:[self.selectedFile path]];
            [[NSWorkspace sharedWorkspace] openFile:[self.selectedFile path]];
        }

        notification.soundName = NSUserNotificationDefaultSoundName;

        [[NSUserNotificationCenter defaultUserNotificationCenter] deliverNotification:notification];
    }
}
@end
