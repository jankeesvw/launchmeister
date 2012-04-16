//
//  LMAppDelegate.h
//  LaunchMeister
//
//  Created by Jankees Woezik on 15-04-12.
//  Copyright (c) 2012 Twelve Twenty. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class LMLaunchPadController;

@interface LMAppDelegate : NSObject <NSApplicationDelegate>

@property(assign) IBOutlet NSWindow *window;
@property(nonatomic, strong) NSMutableArray *launchPads;
@end