#import "LMSerialConnection.h"

@interface LMSerialConnection ()
@property(nonatomic, strong) NSArray *launchPads;
@end

@implementation LMSerialConnection
@synthesize launchPads = _launchPads;

- (id)init
{
    self = [super init];
    if (self)
    {
        NSLog(@"init serial connection");
    }

    return self;
}

- (void)saveLaunchPads:(NSArray *)pads
{
    self.launchPads = pads;
}
@end