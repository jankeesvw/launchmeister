#import <Foundation/Foundation.h>
#import "EESingleton.h"

@interface LMSerialConnection : EESingleton

- (void)saveLaunchPads:(NSArray *)array;
@end