#import <Foundation/Foundation.h>

@protocol LMLaunchPadProtocol;

@interface LMLaunchPad : NSView

@property (nonatomic, assign) id <LMLaunchPadProtocol> delegate;

@end