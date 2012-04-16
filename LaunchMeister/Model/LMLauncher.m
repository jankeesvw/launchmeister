#import "LMLauncher.h"
#import "LMSerialConnection.h"

@interface LMLauncher ()
@property(nonatomic, strong) LMSerialConnection *connection;
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
@end