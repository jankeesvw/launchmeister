#import <Foundation/Foundation.h>
#include <IOKit/IOKitLib.h>
#include <IOKit/serial/IOSerialKeys.h>
#include <IOKit/IOBSD.h>
#include <IOKit/serial/ioss.h>
#include <sys/ioctl.h>
#import "EESingleton.h"

@class LMLauncher;
@protocol LMSerialConnectionDelegate;

@interface LMSerialConnection : EESingleton

@property(nonatomic, assign) id <LMSerialConnectionDelegate> delegate;

@property(nonatomic, assign) BOOL connected;
- (void)resetConnection;
- (void)resetConnectionWithDelay:(float)delay;
@end