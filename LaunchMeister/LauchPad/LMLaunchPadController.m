//
//  TTDropAreaViewController.m
//  LaunchMeister
//
//  Created by Jankees Woezik on 15-04-12.
//  Copyright (c) 2012 Twelve Twenty. All rights reserved.
//

#import "LMLaunchPadController.h"
#import "LMLaunchPad.h"

@implementation LMLaunchPadController
{
}

@synthesize image;
@synthesize title;
@synthesize dropArea;
@synthesize selectedFile = _selectedFile;
@synthesize address = _address;

- (void)loadView
{
    [super loadView];
    self.dropArea.delegate = self;
}


- (void)awakeFromNib
{
    [super awakeFromNib];
    [self setSelectedFile:self.selectedFile];
}

- (void)setSelectedFile:(NSURL *)aSelectedFile
{
    _selectedFile = aSelectedFile;

    if ([_selectedFile path])
    {
        NSImage *imageFromURL = [[NSWorkspace sharedWorkspace] iconForFile:[_selectedFile path]];

        [imageFromURL setSize:NSMakeSize(128, 128)];
        self.image.image = imageFromURL;

        self.title.stringValue = [[self.selectedFile path] lastPathComponent];
    } else
    {
        self.title.stringValue = @"Drop a file";
    }
}

- (void)fileDropped:(NSURL *)url
{
    self.selectedFile = url;
}

- (IBAction)launchApp:(id)sender
{
    if (![[self.selectedFile path] isEqualToString:@""])
    {
        [[NSWorkspace sharedWorkspace] launchApplication:[self.selectedFile path]];
        [[NSWorkspace sharedWorkspace] openFile:[self.selectedFile path]];
    }
}
@end
