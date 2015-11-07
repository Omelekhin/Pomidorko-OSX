//
//  Functions.swift
//  Pomidorko
//
//  Created by Volter on 22.10.15.
//  Copyright (c) 2015 volter9. All rights reserved.
//

import Cocoa

func flatify(window: NSWindow, color: NSColor)
{
    window.backgroundColor = color
    window.titlebarAppearsTransparent = true
    window.styleMask |= NSFullSizeContentViewWindowMask
}

/** Attributed string functions */

func colorize(string: NSMutableAttributedString, color: NSColor)
{
    let range: NSRange = NSMakeRange(0, string.length)
    
    string.addAttribute(
        NSForegroundColorAttributeName,
        value: color, range: range
    )
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

/** Path */

func getFileURL(fileName: String) -> NSURL {
    let manager = NSFileManager.defaultManager()
    var dirURL: NSURL?
    
    do {
        dirURL = try manager.URLForDirectory(
            .DocumentDirectory,
            inDomain: .UserDomainMask,
            appropriateForURL: nil,
            create: false
        )
    } catch {
        print(error)
    }
    
    return (dirURL?.URLByAppendingPathComponent(fileName))!
}

func pad(target: String, subject: String) -> String
{
    return subject.substringFromIndex(target.endIndex) + target
}