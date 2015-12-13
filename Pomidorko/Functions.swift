//
//  Functions.swift
//  Pomidorko
//
//  Created by Volter on 22.10.15.
//  Copyright (c) 2015 volter9. All rights reserved.
//

import Cocoa
import AVFoundation

func flatify(window: NSWindow, color: NSColor)
{
    window.backgroundColor = color
    window.titlebarAppearsTransparent = true
    window.styleMask |= NSFullSizeContentViewWindowMask
}

/** Attributed string functions */

func timeFont(size: CGFloat) -> NSFont
{
    var font: NSFont
    
    if #available(OSX 10.11, *) {
        let weight = size > 70 ? NSFontWeightUltraLight : NSFontWeightRegular
        
        font = NSFont.monospacedDigitSystemFontOfSize(size, weight: weight)
    }
    else {
        font = NSFont(name: "LatoUltraLight", size: size)!
    }
    
    return font
}

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

func timeString(time: Double) -> String
{
    let min = Int(time / 60)
    let sec = Int(time % 60)
    
    return pad(String(min), subject: "00") + ":"
         + pad(String(sec), subject: "00")
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

/** Sounds */

func getSound(name: String) -> AVAudioPlayer?
{
    var player: AVAudioPlayer?
    let url = NSURL(fileURLWithPath:
        NSBundle.mainBundle().pathForResource(name, ofType: "mp3")!
    )
    
    do {
        player = try AVAudioPlayer(contentsOfURL: url)
        player?.prepareToPlay()
    }
    catch {
        print("Error loading '\(name)' sound!")
    }
    
    return player
}