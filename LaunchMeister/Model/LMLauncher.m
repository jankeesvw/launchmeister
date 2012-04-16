#import "LMLauncher.h"
#import "LMSerialConnection.h"
#import "LMLaunchPadController.h"

@interface LMLauncher ()
@property(nonatomic, strong) LMSerialConnection *connection;
- (NSArray *)getAddresses;
@end

@implementation LMLauncher
@synthesize connection = _connection;
@synthesize launchPads = _launchPads;

- (id)init
{
    self = [super init];
    if (self)
    {
        self.connection = [LMSerialConnection instance];
        self.connection.delegate = self;
    }

    return self;
}

- (void)didReceiveSignal:(NSString *)address
{
    for (LMLaunchPadController *pad in self.launchPads)
    {
        if ([pad.address isEqualToString:address])
        {
            NSLog(@"Launch pad at address: %@ with file: %@", address, [pad.selectedFile path]);
            [[NSWorkspace sharedWorkspace] launchApplication:[pad.selectedFile path]];
            [[NSWorkspace sharedWorkspace] openFile:[pad.selectedFile path]];
            return;
        }
    }
    NSLog(@"no launch pad for: %@", address);
}

- (void)setLaunchPads:(NSMutableArray *)aLaunchPads
{
    _launchPads = aLaunchPads;
    NSArray *addresses = [self getAddresses];

    NSUInteger i = 0;
    for (LMLaunchPadController *pad in self.launchPads)
    {
        pad.address = [addresses objectAtIndex:i];
        i++;
    }
}


- (NSArray *)getAddresses
{
    NSMutableArray *addresses = [NSMutableArray array];
    [addresses addObject:@"A1000"];
    [addresses addObject:@"A0100"];
    [addresses addObject:@"A0010"];
    [addresses addObject:@"A0001"];
    [addresses addObject:@"B1000"];
    [addresses addObject:@"B0100"];
    [addresses addObject:@"B0010"];
    [addresses addObject:@"B0001"];
    return addresses;
}
@end