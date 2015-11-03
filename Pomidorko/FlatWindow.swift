//
//  FlatWindow.swift
//  Pomidorko
//
//  Created by Volter on 31.10.15.
//  Copyright © 2015 volter9. All rights reserved.
//

import Cocoa

class FlatWindow: NSWindow
{
    override init(contentRect: NSRect, styleMask aStyle: Int, backing bufferingType: NSBackingStoreType, `defer` flag: Bool) {
        var newStyle: Int
        
        if aStyle & NSTexturedBackgroundWindowMask != 0 {
            newStyle = aStyle;
        } else {
            newStyle = (NSTexturedBackgroundWindowMask | aStyle);
        }
        
        super.init(contentRect: contentRect, styleMask:newStyle, backing: bufferingType, `defer`: flag)
        
        self.backgroundColor = self.addBorderToBackground()
        
        NSNotificationCenter.defaultCenter().addObserver(
            self,
            selector: Selector("windowDidResize"),
            name: NSWindowDidResizeNotification,
            object: self
        )

    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func windowDidResize()
    {
        self.backgroundColor = self.addBorderToBackground()
    }
    
    func addBorderToBackground() -> NSColor
    {
        let bg = NSImage.init(size: self.frame.size)
        
        // Begin drawing into our main image
        bg.lockFocus()
        
        BlueColor.set()

        NSRectFill(NSMakeRect(0, 0, bg.size.width, bg.size.height))

        hex(0x008484).set()

        let bounds = NSMakeRect(0, 0, self.frame.size.width, self.frame.size.height);
        let border = NSBezierPath.init(roundedRect: bounds, xRadius: 3, yRadius: 3)
        
        border.stroke()
        bg.unlockFocus()

        return NSColor.init(patternImage: bg)
    }
}
