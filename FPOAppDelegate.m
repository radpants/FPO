//
//  FPOAppDelegate.m
//  FPO
//
//  Created by AJ Austinson on 2/2/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "FPOAppDelegate.h"

@implementation FPOAppDelegate

@synthesize window;

NSString *LOREM_IPSUM = @"Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.";

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
	// Insert code here to initialize your application 
}


- (void)awakeFromNib{
	statusItem = [[[NSStatusBar systemStatusBar] statusItemWithLength:NSVariableStatusItemLength] retain];
	[statusItem setMenu: statusMenu];
	[statusItem setTitle: @"FPO"];
	
	[loremIpsumItem setAction:@selector(copyLoremIpsum:)];
	[fpoImageItem setAction:@selector(openFpoImageWindow:)];
	[quitItem setAction:@selector(quitApplication:)];
	
	[window setDefaultButtonCell: copyImageButton];
	
	//NSRect testRect = { 0, 0, 80, 20 };
	//NSImage *img = [self fpoImageWithRect: testRect];
	//[self copyImageToClipboard: [img TIFFRepresentation]];
}

- (IBAction)createFpoImage:(id)sender{
	CGFloat w = [widthInput floatValue];
	CGFloat h = [heightInput floatValue];
	NSRect rect = { 0, 0, w, h };
    NSImage *img;
    if( [placekittenCheckbox state] == NSOffState ){
        img = [self fpoImageWithRect: rect];
    }
    else{
        img = [self placekittenWithRect: rect];
    }
	
	[self copyImageToClipboard: [img TIFFRepresentation]];
	[window orderOut:nil];
}

- (void)openFpoImageWindow:(id)sender{
	NSLog(@"clicked");
	[window makeKeyAndOrderFront:nil];
}

- (void)copyLoremIpsum:(id)sender{
	NSLog(@"copying to clipboard");
	[self copyToClipboard: LOREM_IPSUM];
}

- (void)quitApplication:(id)sender{
	[NSApp terminate: nil];
}

- (NSImage *)placekittenWithRect:(NSRect)rect{
    NSString *urlString = [[NSString alloc] initWithFormat: @"http://placekitten.com/%d/%d", (int)rect.size.width, (int)rect.size.height];
    NSLog(@"trying to get url: %@", urlString);
    NSURL *url = [[NSURL alloc] initWithString: urlString];
    NSImage *output = [[NSImage alloc] initWithContentsOfURL: url];
    return output;
}

- (NSImage *)fpoImageWithRect:(NSRect)rect{
	NSImage *output;
	output = [[NSImage alloc] initWithSize: rect.size];
	[output lockFocus];
	[[NSGraphicsContext currentContext] setImageInterpolation: NSImageInterpolationHigh];
	
	// drawing code
	
	NSString *testString = @"FPO";
	
	NSBezierPath *rectPath = [NSBezierPath bezierPathWithRect: rect];
	
	[[NSColor lightGrayColor] set];
	[rectPath fill];
	
	
	CGFloat lineWidth = rect.size.width > rect.size.height ? rect.size.height * 0.1 : rect.size.width * 0.1;

	[[NSColor darkGrayColor] set];
	[rectPath setLineWidth: lineWidth];
	[rectPath stroke];
	
	CGContextRef context = [[NSGraphicsContext currentContext] graphicsPort];
	NSInteger len = [testString length];
	
	
	
	CGFloat fontSize = rect.size.width <= rect.size.height ? rect.size.width * 0.3 : rect.size.height * 0.5;
	CGFloat y = ( rect.size.height / 2.0 ) - (( fontSize / 2.0 ) - ( fontSize / 8.0 ));
	CGFloat x = ( rect.size.width / 2.0 ) - fontSize;
	
	CGContextSelectFont(context, "Helvetica-Bold", fontSize, kCGEncodingMacRoman);
	CGContextSetRGBFillColor(context, 0.5, 0.5, 0.5, 1.0);
	CGContextShowTextAtPoint(context, x, y, [testString cStringUsingEncoding: NSASCIIStringEncoding], len);
	
	//
	
	
	[output unlockFocus];
	return output;
}

- (void)copyToClipboard:(NSString *)string{
	NSPasteboard *pasteboard = [NSPasteboard generalPasteboard];
	[pasteboard clearContents];	
	[pasteboard setString:string forType:NSPasteboardTypeString];
}

- (void)copyImageToClipboard:(NSData *)image{
	NSPasteboard *pasteboard = [NSPasteboard generalPasteboard];
	[pasteboard clearContents];
	[pasteboard setData:image forType:NSPasteboardTypeTIFF];
}

@end
