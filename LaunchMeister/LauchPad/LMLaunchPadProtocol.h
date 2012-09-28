@protocol LMLaunchPadProtocol <NSObject>

- (void)fileDropped:(NSURL *)url;
- (IBAction)launchApp:(id)sender;

@end