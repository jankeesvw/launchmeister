//
//  TTDropAreaViewController.h
//  LaunchMeister
//
//  Created by Jankees Woezik on 15-04-12.
//  Copyright (c) 2012 Twelve Twenty. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "LMLaunchPadProtocol.h"

@class LMLaunchPad;

@interface LMLaunchPadController : NSViewController <LMLaunchPadProtocol>

@property(strong) IBOutlet NSImageView *image;
@property(strong) IBOutlet NSTextField *title;
@property(strong) IBOutlet LMLaunchPad *dropArea;

@property(nonatomic, strong) NSURL *selectedFile;

- (IBAction)launchApp:(id)sender;

@end
