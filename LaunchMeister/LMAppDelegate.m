//
//  LMAppDelegate.m
//  LaunchMeister
//
//  Created by Jankees Woezik on 15-04-12.
//  Copyright (c) 2012 Twelve Twenty. All rights reserved.
//

#import "LMAppDelegate.h"
#import "LMLaunchPadController.h"
#import "LMLaunchMeisterModel.h"
#import "LMLauncher.h"
#import "LMStatusItemView.h"

@interface LMAppDelegate ()
@property(nonatomic, strong) LMLauncher *launcher;
- (void)openMainWindow;
- (NSArray *)getCurrentUrls;
@end

@implementation LMAppDelegate

@synthesize window = _window;
@synthesize launchPads = _launchPads;
@synthesize launcher = _launcher;
@synthesize statusBarItem = _statusBarItem;
@synthesize statusItemView = _statusItemView;

- (BOOL)application:(NSApplication *)sender openFile:(NSString *)filename
{
    NSLog(@"openFile: %@", filename);

    NSArray *selectedFiles = [LMLaunchMeisterModel loadLaunchPadsFromPath:filename];

    int i = 0;
    for (LMLaunchPadController *launchPad in self.launchPads)
    {
        NSURL *url = [selectedFiles count] > i ? [selectedFiles objectAtIndex:i] : [NSURL URLWithString:@""];
        launchPad.selectedFile = url;
        i++;
    }

    [self updateWindowTitle];

    return YES;
}


- (void)applicationWillTerminate:(NSNotification *)notification
{
    [LMLaunchMeisterModel saveLaunchPadsToCurrentFile:[self getCurrentUrls]];
}

- (void)updateWindowTitle
{
    [self.window setTitle:[NSString stringWithFormat:@"LaunchMeister - %@", [LMLaunchMeisterModel getPreviousPath]]];
}

- (void)triggerShowMainWindow
{
    [self openMainWindow];
}


- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{

    self.launcher = [LMLauncher instance];
    self.launcher.delegate = self;
    NSArray *previousFiles = [LMLaunchMeisterModel getLaunchPads];

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

    NSButton *button = [[NSButton alloc] initWithFrame:NSMakeRect(0, 0, 16, 16)];
    button.bezelStyle = NSNoBorder;
    button.image = [NSImage imageNamed:@"SmallLEDYellow"];
    self.launcher.connectionStatusDisplay = button;
    [self.window.contentView addSubview:button];

    [self.launcher setLaunchPads:self.launchPads];

    [self updateWindowTitle];
    [self initializeStatusBarItem];
}

- (void)openMainWindow
{
    if (![self.window isVisible])
    {

        [[NSApplication sharedApplication] activateIgnoringOtherApps:YES];
        [self.window makeKeyAndOrderFront:self];
    } else
    {
        [self.window close];
    }
}

- (void)didClickStatusItem
{
    [self openMainWindow];
}

- (void)initializeStatusBarItem
{
    NSRect statusBarViewRect = NSMakeRect(0, 0, 13, [[NSStatusBar systemStatusBar] thickness]);

    self.statusBarItem = [[NSStatusBar systemStatusBar] statusItemWithLength:statusBarViewRect.size.width + 10];

    self.statusItemView = [[LMStatusItemView alloc] initWithFrame:statusBarViewRect];
    self.statusItemView.delegate = self;

    [self.statusBarItem setView:self.statusItemView];
}

- (IBAction)didClickSave:(id)sender
{
    NSSavePanel *createPanel = [[NSSavePanel alloc] init];
    [createPanel setCanCreateDirectories:YES];
    int result = [createPanel runModal];
    if (result == 1)
    {
        [LMLaunchMeisterModel saveLaunchPads:[self getCurrentUrls] toUrl:[createPanel URL]];
    }
}

- (void)startNewFile
{
    NSSavePanel *createPanel = [[NSSavePanel alloc] init];
    [createPanel setCanCreateDirectories:YES];
    int result = [createPanel runModal];
    if (result == 1)
    {

        [LMLaunchMeisterModel saveLaunchPads:[NSArray array] toUrl:[createPanel URL]];

        int i = 0;
        for (LMLaunchPadController *launchPad in self.launchPads)
        {
            launchPad.selectedFile = [NSURL URLWithString:@""];
            i++;
        }
    }

    [self updateWindowTitle];
}

- (IBAction)didClickNew:(id)sender
{
    [self startNewFile];
}


- (NSArray *)getCurrentUrls
{
    NSMutableArray *selectedFiles = [NSMutableArray array];
    for (LMLaunchPadController *launchPad in self.launchPads)
    {
        [selectedFiles addObject:launchPad.selectedFile];
    }
    return selectedFiles;
}
@end
