//
//  FPOAppDelegate.h
//  FPO
//
//  Created by AJ Austinson on 2/2/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface FPOAppDelegate : NSObject <NSApplicationDelegate> {
	NSWindow *window;
	IBOutlet NSMenu *statusMenu;
	
	IBOutlet NSMenuItem *loremIpsumItem;
	IBOutlet NSMenuItem *fpoImageItem;
	IBOutlet NSMenuItem *quitItem;
	
	IBOutlet NSTextField *heightInput;
	IBOutlet NSTextField *widthInput;
	IBOutlet NSButton *copyImageButton;
    IBOutlet NSPopUpButton *imageSourcePopUp;
    
    NSImage *menuIcon;
	
	NSStatusItem *statusItem;
}

@property (assign) IBOutlet NSWindow *window;

// actions for buttons
- (void)copyLoremIpsum:(id)sender;
- (void)quitApplication:(id)sender;
- (IBAction)createFpoImage:(id)sender;
- (IBAction)takeFocusToWidth:(id)sender;
- (IBAction)takeFocusToHeight:(id)sender;
- (IBAction)takeFocusToPopUp:(id)sender;

// helpers
- (NSImage *)fpoImageWithRect:(NSRect)rect;
- (NSImage *)fpoImageFromInternet:(NSRect)rect;
- (void)copyToClipboard:(NSString*)string;
- (void)copyImageToClipboard:(NSData *)image;

@end
