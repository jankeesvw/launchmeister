#import <Foundation/Foundation.h>
#import "EESingleton.h"

@interface TTLaunchMeisterModel : EESingleton

+ (void) saveLaunchPads:(NSArray *)launchPads;


+ (NSArray *)getLaunchPads;
@end