//
//  MiniWindow.m
//  FPO
//
//  Created by AJ Austinson on 5/31/11.
//  Copyright 2011 AJ Austinson. All rights reserved.
//

#import "MiniWindow.h"
#import "MiniWindowFrame.h"

#import <QuartzCore/QuartzCore.h>


@implementation MiniWindow

- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

- (id)initWithContentRect:(NSRect)contentRect 
                styleMask:(NSUInteger)aStyle 
                  backing:(NSBackingStoreType)bufferingType 
                    defer:(BOOL)flag{
    
    shownFrame = contentRect;
    hiddenFrame = contentRect;
    hiddenFrame.origin.y += 200;
    
    self = [super initWithContentRect:hiddenFrame 
                            styleMask:NSBorderlessWindowMask 
                              backing:bufferingType 
                                defer:flag];
    if(self){
        [self setOpaque: NO];
        [self setBackgroundColor: [NSColor clearColor]];
        [self setLevel:NSModalPanelWindowLevel];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(mainWindowChanged:) name:NSWindowDidBecomeMainNotification object:self];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(mainWindowChanged:) name:NSWindowDidResignMainNotification object:self];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(windowDiscarded:) name:NSWindowDidResignKeyNotification object:self];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(windowOpened:) name:NSWindowDidBecomeKeyNotification object:self];
        
        
        
        
    }    
    return self;
}

- (void)mainWindowChanged:(NSNotification *)aNotification{
    [closeButton setNeedsDisplay];
}

- (void)windowOpened:(NSNotification *)aNotification{
    [self.animator setFrame:hiddenFrame display:YES animate:NO];
    [self.animator setFrame:shownFrame display:YES animate:YES];
    [self.animator setAlphaValue:1.0];
}

- (void)windowDiscarded:(NSNotification *)aNotification{
    [self.animator setFrame: hiddenFrame display:YES animate:YES];
    [self.animator setAlphaValue:0.0];    
}

- (NSRect)contentRectForFrameRect:(NSRect)frameRect{
    frameRect.origin = NSZeroPoint;
    return NSInsetRect(frameRect, WINDOW_FRAME_PADDING, WINDOW_FRAME_PADDING);
}

+ (NSRect)frameRectForContentRect:(NSRect)cRect styleMask:(NSUInteger)aStyle{
    return NSInsetRect(cRect, -WINDOW_FRAME_PADDING, -WINDOW_FRAME_PADDING);
}

- (BOOL)windowShouldClose:(id)window
{
    // Animate the window's alpha value so it fades out.
    [self.animator setAlphaValue:0.0];
    // Don't close the window immediately so we can see the animation.
    return NO;
}

- (void)setContentView:(NSView *)aView{
    if([childContentView isEqualTo:aView]){
        return;
    }
    
    NSRect bounds = [self frame];
    bounds.origin = NSZeroPoint;
    
    MiniWindowFrame *frameView = [super contentView];
    if(!frameView){
        frameView = [[[MiniWindowFrame alloc] initWithFrame:bounds] autorelease];
        
        [super setContentView: frameView];
        
        closeButton = [NSWindow standardWindowButton:NSWindowCloseButton forStyleMask:NSTitledWindowMask];
        NSRect closeButtonRect = [closeButton frame];
        [closeButton setFrame:NSMakeRect(WINDOW_FRAME_PADDING - 20, bounds.size.height - (WINDOW_FRAME_PADDING - 20) - closeButtonRect.size.height, closeButtonRect.size.width, closeButtonRect.size.height)];
        [closeButton setAutoresizingMask:NSViewMinXMargin | NSViewMinYMargin];
        [frameView addSubview: closeButton];
    }
    
    if(childContentView){
        [childContentView removeFromSuperview];
    }
    
    childContentView = aView;
    [childContentView setFrame: [self contentRectForFrameRect:bounds]];
    [childContentView setAutoresizingMask: NSViewWidthSizable | NSViewHeightSizable];
    [frameView addSubview:childContentView];
}

- (NSView *)contentView{
    return childContentView;
}

- (BOOL)canBecomeKeyWindow{
    return YES;
}

- (BOOL)canBecomeMainWindow{
    return YES;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver: self];
    [super dealloc];
}

@end
