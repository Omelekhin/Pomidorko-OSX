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

        layer?.borderWidth = 0.0
        
        let context = NSGraphicsContext.currentContext()?.CGContext
        
        let colors = [hex(0x5caefd).CGColor, hex(0x0572ff).CGColor]
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let colorLocations:[CGFloat] = [0.0, 1.0]
        
        let gradient = CGGradientCreateWithColors(colorSpace, colors, colorLocations)

        let startPoint = CGPoint.zero
        let endPoint = CGPoint(x: 0, y: self.bounds.height)
        
        CGContextDrawLinearGradient(
            context,
            gradient,
            startPoint,
            endPoint,
            CGGradientDrawingOptions(rawValue: 0)
        )
        
        let attributes = [
            NSForegroundColorAttributeName: WhiteColor,
            NSFontAttributeName: NSFont.systemFontOfSize(16)
        ]
        
        NSString(string: title).drawAtPoint(
            NSMakePoint(9, 4),
            withAttributes: attributes
        )
    }
    
    func gradient() -> CALayer
    {
        let gradient = CAGradientLayer()
        gradient.frame = bounds
        gradient.colors = [hex(0x5caefd).CGColor, hex(0x0572ff).CGColor]
        
        return gradient
    }
}
