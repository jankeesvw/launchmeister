#import <Foundation/Foundation.h>

@protocol LMStatusItemViewDelegate;

@interface LMStatusItemView : NSView

@property(nonatomic, assign) id <LMStatusItemViewDelegate> delegate;
- (void)setToUpState;

@end