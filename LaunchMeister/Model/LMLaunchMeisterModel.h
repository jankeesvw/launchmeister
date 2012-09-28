#import <Foundation/Foundation.h>
#import "EESingleton.h"

@interface LMLaunchMeisterModel : EESingleton

+ (NSArray *)getLaunchPads;
+ (NSString *)getPreviousPath;
+ (void)saveLaunchPads:(NSArray *)launchPads toUrl:(NSURL *)url;
+ (NSArray *)loadLaunchPadsFromPath:(NSString *)path;
+ (void)saveLaunchPadsToCurrentFile:(NSArray *)array;
@end