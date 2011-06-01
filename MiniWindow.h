//
//  MiniWindow.h
//  FPO
//
//  Created by AJ Austinson on 5/31/11.
//  Copyright 2011 AJ Austinson. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface MiniWindow : NSPanel {
@private
    NSView *childContentView;
    NSButton *closeButton;
    
    NSRect shownFrame;
    NSRect hiddenFrame;
}

@end
