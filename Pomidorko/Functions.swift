//
//  Functions.swift
//  Pomidorko
//
//  Created by Volter on 22.10.15.
//  Copyright (c) 2015 volter9. All rights reserved.
//

import Cocoa

/** Color functions */

func rgb(red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat = 1.0) -> NSColor
{
    return NSColor(
        red: red / 255,
        green: green / 255,
        blue: blue / 255,
        alpha: alpha
    )
}

func hex(hex: Int, alpha: CGFloat = 1.0) -> NSColor
{
    return rgb(
        CGFloat(hex >> 16 & 0xff),
        green: CGFloat(hex >> 8  & 0xff),
        blue:  CGFloat(hex       & 0xff),
        alpha: alpha
    )
}

func flatify(window: NSWindow, color: NSColor)
{
    window.backgroundColor = color
    window.titlebarAppearsTransparent = true
    window.styleMask |= NSFullSizeContentViewWindowMask
}

/** Attributed string functions */

func colorize(string: NSAttributedString?, color: NSColor) -> NSMutableAttributedString
{
    let result: NSMutableAttributedString = NSMutableAttributedString(attributedString: string!)
    let range: NSRange = NSMakeRange(0, string!.length)
    
    result.addAttribute(
        NSForegroundColorAttributeName,
        value: color, range: range
    );
    
    return result;
}

func increase(string: NSMutableAttributedString, font: NSFont, offset: Int, length: Int)
{
    let range: NSRange = NSMakeRange(offset, length)
    
    string.addAttribute(
        NSFontAttributeName,
        value: font, range: range
    )
}

func align(string: NSMutableAttributedString, alignment: NSTextAlignment)
{
    let style = NSMutableParagraphStyle()
    let range = NSMakeRange(0, string.length)
    
    style.alignment = alignment
    
    string.addAttribute(NSParagraphStyleAttributeName, value: style, range: range)
}

func localeString(key: String) -> String
{
    return NSLocalizedString(key, comment: "")
}

/** Time */

func now() -> Double
{
    return NSDate().timeIntervalSince1970 * 1000.0
}