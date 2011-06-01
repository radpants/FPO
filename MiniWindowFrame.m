//
//  MiniWindowFrame.m
//  FPO
//
//  Created by AJ Austinson on 5/31/11.
//  Copyright 2011 AJ Austinson. All rights reserved.
//

#import "MiniWindowFrame.h"


@implementation MiniWindowFrame

- (id)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        backgroundImage = [[NSImage alloc] initWithContentsOfFile: [[NSBundle mainBundle]pathForImageResource:@"bg.png"]];
    }
    
    return self;
}

- (void)dealloc
{
    [super dealloc];
}

- (void)drawRect:(NSRect)dirtyRect
{
    [backgroundImage drawAtPoint:NSZeroPoint fromRect:NSZeroRect operation:NSCompositeCopy fraction:1.0f];
}

@end
