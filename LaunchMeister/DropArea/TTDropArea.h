#import <Foundation/Foundation.h>

@protocol TTDropAreaProtocol;

@interface TTDropArea : NSView

@property (nonatomic, assign) id <TTDropAreaProtocol> delegate;

@end