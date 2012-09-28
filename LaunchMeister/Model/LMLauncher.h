#import <Foundation/Foundation.h>
#import "EESingleton.h"
#import "LMSerialConnectionDelegate.h"

@class LMSerialConnection;
@class LMAppDelegate;
@protocol LMLauncherDelegate;

@interface LMLauncher : EESingleton <LMSerialConnectionDelegate>

@property(nonatomic, strong) NSMutableArray *launchPads;

@property(nonatomic, assign) NSButton *connectionStatusDisplay;
@property(nonatomic, assign) id <LMLauncherDelegate> delegate;
@end