//
//  TOAppDelegate.m
//  TakeOut
//
//  Created by Justin R. Miller on 12/10/13.
//  Copyright (c) 2013 MapBox. All rights reserved.
//

#import "TOAppDelegate.h"

#import "TOStatusView.h"

@interface TOAppDelegate ()

@property (nonatomic) NSStatusItem *statusItem;

@end

#pragma mark -

@implementation TOAppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    self.statusItem = [[NSStatusBar systemStatusBar] statusItemWithLength:NSSquareStatusItemLength];

    [self.statusItem setView:[[TOStatusView alloc] initWithFrame:CGRectMake(0, 0, [[NSStatusBar systemStatusBar] thickness], [[NSStatusBar systemStatusBar] thickness])]];
}

@end
