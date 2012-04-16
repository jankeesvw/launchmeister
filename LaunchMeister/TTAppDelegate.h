//
//  TTAppDelegate.h
//  LaunchMeister
//
//  Created by Jankees Woezik on 15-04-12.
//  Copyright (c) 2012 Twelve Twenty. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class TTDropAreaViewController;

@interface TTAppDelegate : NSObject <NSApplicationDelegate>

@property(assign) IBOutlet NSWindow *window;
@property(nonatomic, strong) TTDropAreaViewController *dropAreaOne;
@property(nonatomic, strong) TTDropAreaViewController *dropAreaTwo;
@property(nonatomic, strong) TTDropAreaViewController *dropAreaThree;
@property(nonatomic, strong) TTDropAreaViewController *dropAreaFour;
@end
