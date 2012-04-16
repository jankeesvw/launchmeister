#import <Foundation/Foundation.h>
#import "EESingleton.h"

@class LMSerialConnection;

@interface LMLauncher : EESingleton
@property(nonatomic, strong) NSMutableArray *launchPads;
@end