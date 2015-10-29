//
//  Scale.swift
//  Pomidorko
//
//  Created by Volter on 22.10.15.
//  Copyright (c) 2015 volter9. All rights reserved.
//

import Cocoa

class Scale: NSView
{
    override func drawRect(dirtyRect: NSRect)
    {
        let context = NSGraphicsContext.currentContext()?.CGContext
        
        CGContextSetFillColorWithColor(context, WhiteColor.CGColor)
        CGContextSetFontSize(context, 10)
        
        for index in 0..<55 {
            let x: CGFloat = CGFloat(index * 40) + 10
            
            if x > dirtyRect.width {
                break
            }
            
            strip(
                context!,
                x: x,
                y: 40,
                h: CGFloat(index % 5 == 0 ? 60 : 37)
            )
            CGContextFillPath(context)
            CGContextSetTextPosition(context, x, 30)
            
            if index % 5 == 0 {
                NSString(format: "%i", Int(25 - index)).drawAtPoint(
                    NSMakePoint(x - 7, 20),
                    withAttributes: [NSForegroundColorAttributeName: WhiteColor]
                )
            }
        }
    }
}