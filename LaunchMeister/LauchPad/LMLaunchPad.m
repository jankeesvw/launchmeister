#import "LMLaunchPad.h"
#import "LMLaunchPadProtocol.h"

@implementation LMLaunchPad
@synthesize delegate = _delegate;

- (id)initWithFrame:(NSRect)frameRect
{
    self = [super initWithFrame:frameRect];
    if (self)
    {
        [self registerForDraggedTypes:[NSArray arrayWithObjects:NSColorPboardType, NSFilenamesPboardType, nil]];
    }

    return self;
}


- (void)mouseDown:(NSEvent *)theEvent
{
    [self.delegate launchApp:self];
}


- (NSDragOperation)draggingEntered:(id <NSDraggingInfo>)sender
{
    NSPasteboard *pboard;
    NSDragOperation sourceDragMask;

    sourceDragMask = [sender draggingSourceOperationMask];
    pboard = [sender draggingPasteboard];

    if ([[pboard types] containsObject:NSColorPboardType])
    {
        if (sourceDragMask & NSDragOperationGeneric)
        {
            return NSDragOperationGeneric;
        }
    }
    if ([[pboard types] containsObject:NSFilenamesPboardType])
    {
        if (sourceDragMask & NSDragOperationLink)
        {
            return NSDragOperationLink;
        } else if (sourceDragMask & NSDragOperationCopy)
        {
            return NSDragOperationCopy;
        }
    }
    return NSDragOperationNone;
}

- (BOOL)performDragOperation:(id <NSDraggingInfo>)sender
{
    NSURL *url = [NSURL URLFromPasteboard:[sender draggingPasteboard]];

    [self.delegate fileDropped:url];

    return YES;
}
@end