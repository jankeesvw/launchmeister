//
//  TTDropAreaViewController.m
//  LaunchMeister
//
//  Created by Jankees Woezik on 15-04-12.
//  Copyright (c) 2012 Twelve Twenty. All rights reserved.
//

#import "TTDropAreaViewController.h"
#import "TTDropArea.h"

@interface TTDropAreaViewController ()
@property(nonatomic, strong) id selectedFile;
@end

@implementation TTDropAreaViewController
@synthesize image;
@synthesize title;
@synthesize dropArea;
@synthesize selectedFile = _selectedFile;

- (void)loadView
{
    [super loadView];
    self.dropArea.delegate = self;
}


- (void)fileDropped:(NSURL *)url
{
    self.selectedFile = url;

    NSImage *imageFromURL = [[NSWorkspace sharedWorkspace] iconForFile:[self.selectedFile path]];
    [imageFromURL setSize:NSMakeSize(128, 128)];
    self.image.image = imageFromURL;

    self.title.stringValue = [[self.selectedFile path] lastPathComponent];
}

- (IBAction)launchApp:(id)sender
{
    NSLog(@"url: %@", self.selectedFile);
    [[NSWorkspace sharedWorkspace] launchApplication:[self.selectedFile path]];
    [[NSWorkspace sharedWorkspace] openFile:[self.selectedFile path]];
}
@end
