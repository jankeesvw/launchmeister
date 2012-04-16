#import <Foundation/Foundation.h>
#import "EESingleton.h"

@interface LMLaunchMeisterModel : EESingleton

+ (void) saveLaunchPads:(NSArray *)launchPads;


+ (NSArray *)getLaunchPads;
@end