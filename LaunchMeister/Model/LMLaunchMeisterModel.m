#import "LMLaunchMeisterModel.h"

@interface LMLaunchMeisterModel ()
+ (void)setPreviousPath:(NSString *)path;
@end

@implementation LMLaunchMeisterModel

+ (NSArray *)getLaunchPads
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:[self getPreviousPath]])
    {
        return [NSKeyedUnarchiver unarchiveObjectWithFile:[self getPreviousPath]];
    } else
    {
        return [NSArray array];
    }
}

+ (NSString *)getPreviousPath
{
    NSString *previousPath = (NSString *) [[NSUserDefaults standardUserDefaults] objectForKey:@"path"];
    NSLog(@"getPreviousPath: %@", previousPath);
    return previousPath;
}

+ (void)setPreviousPath:(NSString *)path
{
    if (![[path pathExtension] isEqualToString:@"launchmeister"])
    {
        path = [path stringByAppendingString:@".launchmeister"];
    }

    [[NSUserDefaults standardUserDefaults] setObject:path forKey:@"path"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    NSLog(@"setPreviousPath: %@ - %@", [self getPreviousPath], path);
}

+ (void)saveLaunchPads:(NSArray *)launchPads toUrl:(NSURL *)url
{
    NSString *path = [url path];

    [self setPreviousPath:path];

    [NSKeyedArchiver archiveRootObject:launchPads toFile:[self getPreviousPath]];
}

+ (NSArray *)loadLaunchPadsFromPath:(NSString *)path
{
    [self setPreviousPath:path];

    return [self getLaunchPads];
}

+ (void)saveLaunchPadsToCurrentFile:(NSArray *)array
{
    [self saveLaunchPads:array toUrl:[NSURL URLWithString:[self getPreviousPath]]];
}
@end