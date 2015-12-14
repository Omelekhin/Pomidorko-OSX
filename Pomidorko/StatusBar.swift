//
//  Pie.swift
//  Pomidorko
//
//  Created by Volter on 13.12.15.
//  Copyright © 2015 volter9. All rights reserved.
//

import Cocoa

let StatusBarMarginLeft = 6
let StatusBarMarginTop = 4

class StatusBar: NSView
{
    var isMenuVisible: Bool = false
    var statusItem: NSStatusItem?
    var segment: Double = 1.0
    var title: String = ""
    var color: NSColor = WhiteColor
    
    override func drawRect(dirtyRect: NSRect)
    {
        let context = NSGraphicsContext.currentContext()?.CGContext
        let color   = self.color.CGColor
        let radius  = 7
        
        CGContextSetFillColorWithColor(context!, color)
        CGContextSetStrokeColorWithColor(context!, color)
        
        CGContextBeginPath(context!)
        CGContextAddArc(context!,
            CGFloat(StatusBarMarginLeft + radius),
            CGFloat(StatusBarMarginTop + radius), CGFloat(radius),
            CGFloat(M_PI / 2),
            CGFloat(M_PI / 2 + M_PI * 2 * segment), 0
        )
        CGContextAddLineToPoint(context!,
            CGFloat(StatusBarMarginLeft + radius),
            CGFloat(StatusBarMarginTop + radius)
        )
        CGContextFillPath(context!)
        
        CGContextStrokeEllipseInRect(context!,
            NSMakeRect(
                CGFloat(StatusBarMarginLeft),
                CGFloat(StatusBarMarginTop),
                CGFloat(radius * 2), CGFloat(radius * 2)
            )
        )
        
        let attributes = [
            NSForegroundColorAttributeName: self.color,
            NSFontAttributeName: timeFont(14)
        ]
        
        NSString(string: title).drawAtPoint(
            NSMakePoint(26, CGFloat(StatusBarMarginTop - 1)),
            withAttributes: attributes
        )
    }
    
    func render(segment: Double, title: String)
    {
        self.segment = segment
        self.title = title
        
        needsDisplay = true
    }
}
