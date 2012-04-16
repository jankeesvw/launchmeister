//
//  TTAppDelegate.m
//  LaunchMeister
//
//  Created by Jankees Woezik on 15-04-12.
//  Copyright (c) 2012 Twelve Twenty. All rights reserved.
//

#import "TTAppDelegate.h"
#import "TTDropAreaViewController.h"

@implementation TTAppDelegate
{
    TTDropAreaViewController *dropAreaOne;
    TTDropAreaViewController *dropAreaTwo;
    TTDropAreaViewController *dropAreaThree;
    TTDropAreaViewController *dropAreaFour;
}

@synthesize window = _window;
@synthesize dropAreaOne;
@synthesize dropAreaTwo;
@synthesize dropAreaThree;
@synthesize dropAreaFour;

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    dropAreaOne = [[TTDropAreaViewController alloc] initWithNibName:@"TTDropAreaViewController" bundle:nil];
    [self.window.contentView addSubview:self.dropAreaOne.view];

    dropAreaTwo = [[TTDropAreaViewController alloc] initWithNibName:@"TTDropAreaViewController" bundle:nil];
    [dropAreaTwo.view setFrame:NSMakeRect(200, 0, 200, 200)];
    [self.window.contentView addSubview:self.dropAreaTwo.view];

    dropAreaThree = [[TTDropAreaViewController alloc] initWithNibName:@"TTDropAreaViewController" bundle:nil];
    [dropAreaThree.view setFrame:NSMakeRect(400, 0, 200, 200)];
    [self.window.contentView addSubview:self.dropAreaThree.view];

    dropAreaFour = [[TTDropAreaViewController alloc] initWithNibName:@"TTDropAreaViewController" bundle:nil];
    [dropAreaFour.view setFrame:NSMakeRect(600, 0, 200, 200)];
    [self.window.contentView addSubview:self.dropAreaFour.view];
}

@end
