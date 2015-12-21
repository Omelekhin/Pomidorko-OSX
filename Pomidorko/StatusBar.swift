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

class StatusBar: NSView, NSMenuDelegate
{
    var isMenuVisible: Bool = false
    var statusItem: NSStatusItem?
    var segment: Double = 1.0
    var title: String = ""
    var color: NSColor = WhiteColor
    var alpha: Double = 1
    
    override func drawRect(dirtyRect: NSRect)
    {
        statusItem?.drawStatusBarBackgroundInRect(bounds, withHighlight: isMenuVisible)
        
        let context = NSGraphicsContext.currentContext()?.CGContext
        let color   = (isMenuVisible ? WhiteColor : self.color).CGColor
        let image   = CGBitmapContextCreateImage(renderPie(color))
        
        CGContextSetAlpha(context, CGFloat(alpha))
        CGContextDrawImage(context, NSMakeRect(0, 0, 26, 22), image)
        CGContextSetAlpha(context, 1.0)
        
        CGContextSetFillColorWithColor(context!, color)
        
        let attributes = [
            NSForegroundColorAttributeName: self.color,
            NSFontAttributeName: timeFont(14)
        ]
        
        NSString(string: title).drawAtPoint(
            NSMakePoint(26, CGFloat(StatusBarMarginTop - 1)),
            withAttributes: attributes
        )
    }
    
    func renderPie(color: CGColorRef) -> CGContext
    {
        let context = createBitmapContext(26, 22)
        let factor  = screenFactor()
        let radius  = CGFloat(7 * factor)
        
        let topMargin = CGFloat(StatusBarMarginTop) * factor
        let leftMargin = CGFloat(StatusBarMarginLeft) * factor
        
        CGContextSetLineWidth(context, 1.5 * factor)
        CGContextSetFillColorWithColor(context, color)
        CGContextSetStrokeColorWithColor(context, color)
        
        CGContextStrokeEllipseInRect(context,
            NSMakeRect(
                leftMargin,
                topMargin,
                radius * 2,
                radius * 2
            )
        )
        
        CGContextBeginPath(context)
        CGContextAddArc(context,
            leftMargin + radius,
            topMargin + radius, radius,
            CGFloat(M_PI / 2),
            CGFloat(M_PI / 2 + M_PI * 2 * segment), 0
        )
        CGContextAddLineToPoint(context,
            leftMargin + radius,
            topMargin  + radius
        )
        CGContextFillPath(context)
        
        return context
    }
    
    /**
     * Implementing status bar menu
     */
    
    override func mouseDown(theEvent: NSEvent)
    {
        statusItem?.menu?.delegate = self
        statusItem?.popUpStatusItemMenu((statusItem?.menu)!)
        needsDisplay = true
    }
    
    override func rightMouseDown(theEvent: NSEvent)
    {
        mouseDown(theEvent)
    }
    
    func menuWillOpen(menu: NSMenu)
    {
        isMenuVisible = true
        needsDisplay = true
    }
    
    func menuDidClose(menu: NSMenu)
    {
        isMenuVisible = false
        statusItem?.menu?.delegate = nil
        needsDisplay = true
    }
    
    func render(segment: Double, title: String)
    {
        self.segment = segment
        self.title = title
        
        needsDisplay = true
    }
}
