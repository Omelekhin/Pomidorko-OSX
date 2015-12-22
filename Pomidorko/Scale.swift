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
    var time: Double = 0.0
    
    override func drawRect(dirtyRect: NSRect)
    {
        let context = NSGraphicsContext.currentContext()?.CGContext
        
        CGContextSetFillColorWithColor(context, WhiteColor.CGColor)
        CGContextSetFontSize(context, 10)
        
        for index in 0..<56 {
            let isLabeled: Bool = index % 5 == 0
            let offset: CGFloat = CGFloat(time / 60.0) * 40.0
            let x: CGFloat = dirtyRect.width / 2 + CGFloat(index * 40) - offset
            
            if x < -40 {
                continue
            }
            
            if x > dirtyRect.width {
                break
            }
            
            strip(
                context!,
                x: x,
                y: 40,
                h: CGFloat(isLabeled ? 60 : 37)
            )
            
            CGContextFillPath(context)
            
            if isLabeled {
                NSString(format: "%i", Int(index)).drawAtPoint(
                    NSMakePoint(x - (index < 10 ? 3.5 : 7), 20),
                    withAttributes: [NSForegroundColorAttributeName: WhiteColor]
                )
            }
        }
    }
    
    func moveCursor(time: Double)
    {
        self.time = time
        self.needsDisplay = true
    }
}