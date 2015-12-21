//
//  SettingsBackground.swift
//  Pomidorko
//
//  Created by Volter on 21.12.15.
//  Copyright © 2015 volter9. All rights reserved.
//

import Cocoa

class SettingsBackground: NSView
{
    override func drawRect(dirtyRect: NSRect)
    {
        super.drawRect(dirtyRect)
        
        layer?.backgroundColor = WhiteColor.CGColor
        layer?.cornerRadius = 4.0
        layer?.borderWidth = 1.0
        layer?.borderColor = NSColor(white: 0.0, alpha: 0.2).CGColor
    }
}