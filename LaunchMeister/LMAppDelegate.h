//
//  LMAppDelegate.h
//  LaunchMeister
//
//  Created by Jankees Woezik on 15-04-12.
//  Copyright (c) 2012 Twelve Twenty. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "LMStatusItemViewDelegate.h"
#import "LMLauncherDelegate.h"

@class LMLaunchPadController;
@class LMSerialConnection;
@class LMLauncher;
@class LMStatusItemView;

@interface LMAppDelegate : NSObject <NSApplicationDelegate, LMStatusItemViewDelegate, LMLauncherDelegate>

@property(assign) IBOutlet NSWindow *window;
@property(nonatomic, strong) NSMutableArray *launchPads;

@property(nonatomic, strong) NSStatusItem *statusBarItem;
@property(nonatomic, strong) LMStatusItemView *statusItemView;
- (IBAction)didClickSave:(id)sender;
- (IBAction)didClickNew:(id)sender;


@end

