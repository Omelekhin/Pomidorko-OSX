//
//  SettingsButton.swift
//  Pomidorko
//
//  Created by Volter on 21.12.15.
//  Copyright © 2015 volter9. All rights reserved.
//

import Cocoa

class SettingsButton: NSButton
{
    override func drawRect(dirtyRect: NSRect)
    {
        super.drawRect(dirtyRect)

        drawGradientBackground()
        
        let attributes = [
            NSForegroundColorAttributeName: WhiteColor,
            NSFontAttributeName: NSFont.systemFontOfSize(16)
        ]
        
        NSString(string: title).drawAtPoint(
            NSMakePoint(10, 3),
            withAttributes: attributes
        )
    }
    
    func drawGradientBackground()
    {
        let context = NSGraphicsContext.currentContext()?.CGContext
        
        let colorLocations:[CGFloat] = [0.0, 1.0]
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let colors     = [hex(0x5caefd).CGColor, hex(0x0572ff).CGColor]
        
        let gradient = CGGradientCreateWithColors(colorSpace, colors, colorLocations)

        let startPoint = CGPoint.zero
        let endPoint   = CGPoint(x: 0, y: self.bounds.height)
        
        CGContextDrawLinearGradient(
            context,
            gradient,
            startPoint,
            endPoint,
            CGGradientDrawingOptions(rawValue: 0)
        )
    }
}
