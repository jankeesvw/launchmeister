#import "LMStatusItemView.h"
#import "LMStatusItemViewDelegate.h"

NSImageView *imageView;

@implementation LMStatusItemView

@synthesize delegate = delegate_;

- (id)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        imageView = [[NSImageView alloc] initWithFrame:frame];
        imageView.autoresizingMask = NSViewWidthSizable | NSViewHeightSizable;
        [self setToUpState];
        [self addSubview:imageView];
    }
    return self;
}

- (void)mouseUp:(NSEvent *)theEvent
{
    [self.delegate didClickStatusItem];

    [self setToUpState];
}


- (void)setToUpState
{
    imageView.image = [NSImage imageNamed:@"status-bar-icon"];
}

- (void)mouseDown:(NSEvent *)event;
{
    imageView.image = [NSImage imageNamed:@"status-bar-icon-down"];
}
@end