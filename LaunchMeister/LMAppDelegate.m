//
//  LMAppDelegate.m
//  LaunchMeister
//
//  Created by Jankees Woezik on 15-04-12.
//  Copyright (c) 2012 Twelve Twenty. All rights reserved.
//

#import "LMAppDelegate.h"
#import "LMLaunchPadController.h"
#import "TTLaunchMeisterModel.h"

@implementation LMAppDelegate

@synthesize window = _window;
@synthesize launchPads = _launchPads;

- (void)applicationWillTerminate:(NSNotification *)notification
{
    NSMutableArray *selectedFiles = [NSMutableArray array];
    for (LMLaunchPadController *launchPad in self.launchPads)
    {
        [selectedFiles addObject:launchPad.selectedFile];
    }
    [TTLaunchMeisterModel saveLaunchPads:selectedFiles];
}

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{

    NSArray *previousFiles = [TTLaunchMeisterModel getLaunchPads];

    int numberOfLaunchPads = 8;

    self.launchPads = [NSMutableArray array];

    int y = 0;
    for (NSUInteger pad = 0; pad < numberOfLaunchPads; pad++)
    {
        LMLaunchPadController *dropAreaController = [[LMLaunchPadController alloc] initWithNibName:@"LMLaunchPadController" bundle:nil];
        [self.launchPads addObject:dropAreaController];

        NSURL *url = [previousFiles count] > pad ? [previousFiles objectAtIndex:pad] : [NSURL URLWithString:@""];
        dropAreaController.selectedFile = url;

        int x = pad % 4 * 200;

        if (pad % 4 == 0 && pad != 0) y += 200;

        [dropAreaController.view setFrame:NSMakeRect(x, y, 200, 200)];

        [self.window.contentView addSubview:dropAreaController.view];
    }
}
@end