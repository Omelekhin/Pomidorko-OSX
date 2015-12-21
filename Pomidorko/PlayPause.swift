//
//  PlayPause.swift
//  Pomidorko
//
//  Created by Volter on 22.10.15.
//  Copyright (c) 2015 volter9. All rights reserved.
//

import Cocoa

class PlayPause: HoverableButton
{
    var backgroundColor: NSColor = LightRedColor
    
    override func drawRect(dirtyRect: NSRect)
    {
        let context: CGContext? = NSGraphicsContext.currentContext()?.CGContext
        
        CGContextSetFillColorWithColor(context, backgroundColor.CGColor)
        CGContextFillEllipseInRect(context, dirtyRect)
        
        CGContextSetFillColorWithColor(context, WhiteColor.CGColor)
        CGContextSaveGState(context)
        
        if self.state == 1 {
            CGContextTranslateCTM(context, 32, 25)
            CGContextScaleCTM(context, 0.4, 0.4)
            play(context!)
        }
        else {
            CGContextTranslateCTM(context, 28, 25)
            CGContextScaleCTM(context, 0.4, 0.4)
            pause(context!)
        }
        
        CGContextFillPath(context)
        CGContextRestoreGState(context)
    }
}