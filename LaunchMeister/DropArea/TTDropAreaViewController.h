//
//  TTDropAreaViewController.h
//  LaunchMeister
//
//  Created by Jankees Woezik on 15-04-12.
//  Copyright (c) 2012 Twelve Twenty. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "TTDropAreaProtocol.h"

@class TTDropArea;

@interface TTDropAreaViewController : NSViewController <TTDropAreaProtocol>

@property(strong) IBOutlet NSImageView *image;
@property(strong) IBOutlet NSTextField *title;
@property(strong) IBOutlet TTDropArea *dropArea;

- (IBAction)launchApp:(id)sender;

@end
