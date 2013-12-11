//
//  TOStatusView.m
//  TakeOut
//
//  Created by Justin R. Miller on 12/11/13.
//  Copyright (c) 2013 MapBox. All rights reserved.
//

#import "TOStatusView.h"

@implementation TOStatusView

- (id)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];

    if (self)
    {
        self.image = [NSImage imageNamed:@"restaurant-24.png"];

        [self registerForDraggedTypes:@[ @"public.file-url" ]];
    }

    return self;
}

#pragma mark -

- (NSString *)pathForSender:(id <NSDraggingInfo>)sender
{
    return [[[sender draggingPasteboard] pasteboardItems][0] stringForType:@"public.file-url"];
}

- (BOOL)isValidSender:(id <NSDraggingInfo>)sender
{
    return ([[self pathForSender:sender] hasSuffix:@".json"] || [[self pathForSender:sender] hasSuffix:@".geojson"]);
}

#pragma mark -

- (NSDragOperation)draggingEntered:(id <NSDraggingInfo>)sender
{
    if ([self isValidSender:sender])
        return NSDragOperationCopy;

    return NSDragOperationNone;
}

- (BOOL)performDragOperation:(id <NSDraggingInfo>)sender
{
    if ([self isValidSender:sender])
    {
        NSString *strippedPath   = [[self pathForSender:sender] stringByReplacingOccurrencesOfString:@"file://" withString:@""];
        NSString *contentsString = [[NSString alloc] initWithData:[[NSFileManager defaultManager] contentsAtPath:strippedPath] encoding:NSUTF8StringEncoding];
        NSString *encodedString  = [contentsString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];

        NSURL *fullURL = [NSURL URLWithString:[NSString stringWithFormat:@"http://geojson.io/#data=data:application/json,%@", encodedString]];

        [[NSWorkspace sharedWorkspace] openURL:fullURL];

        return YES;
    }

    return NO;
}

@end
