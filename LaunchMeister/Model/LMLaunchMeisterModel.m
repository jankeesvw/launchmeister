#import "LMLaunchMeisterModel.h"

@interface LMLaunchMeisterModel ()
+ (NSString *)folderPath;
+ (NSString *)filePath;
@end

@implementation LMLaunchMeisterModel

+ (void)saveLaunchPads:(NSArray *)launchPads
{
    [NSKeyedArchiver archiveRootObject:launchPads toFile:[self filePath]];
}

+ (NSString *)folderPath
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSApplicationSupportDirectory, NSUserDomainMask, YES);
    NSString *folderPath = [[paths objectAtIndex:0] stringByAppendingPathComponent:@"Twenty Twelve/LaunchMeister"];


    NSFileManager *fileManager = [NSFileManager defaultManager];

    if (![fileManager fileExistsAtPath:folderPath])
    {
        NSError *error;
        [fileManager createDirectoryAtPath:folderPath withIntermediateDirectories:YES attributes:nil error:&error];
    }

    return folderPath;
}

+ (NSString *)filePath
{

    return [[self folderPath] stringByAppendingPathComponent:@"LaunchPads.plist"];
}

+ (NSArray *)getLaunchPads
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:[self filePath]])
    {
        return [NSKeyedUnarchiver unarchiveObjectWithFile:[self filePath]];
    } else
    {
        return [NSArray array];
    }
}
@end