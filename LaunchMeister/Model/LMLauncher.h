#import <Foundation/Foundation.h>
#import "EESingleton.h"
#import "LMSerialConnectionDelegate.h"

@class LMSerialConnection;

@interface LMLauncher : EESingleton <LMSerialConnectionDelegate>

@property(nonatomic, strong) NSMutableArray *launchPads;

@end