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

func systemFont(size: CGFloat) -> NSFont
{
    var font: NSFont
    
    if #available(OSX 10.11, *) {
        font = NSFont.systemFontOfSize(size, weight: NSFontWeightLight)
    }
    else {
        font = NSFont.systemFontOfSize(size)
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
    return NSDate().timeIntervalSince1970
}

func dateDay(date: NSDate) -> Int
{
    let components = NSCalendar.currentCalendar().components(.Day, fromDate: date)
    
    return components.day
}

func dateHour(date: NSDate) -> Int
{
    let components = NSCalendar.currentCalendar().components(.Hour, fromDate: date)
    
    return components.hour
}

func timeOrdinal(time: Int) -> String
{
    let ending = String(time % 10)
    
    let index = String(time)
    var suffix: String = localeString(index)
    
    if suffix == index {
        suffix = localeString(ending)
    }
    
    if suffix == ending {
        suffix = ""
    }
    
    return index + suffix
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

func screenFactor() -> CGFloat
{
    return (NSScreen.mainScreen()?.backingScaleFactor)!
}

func clamp<T: Comparable>(x: T, _ min: T, _ max: T) -> T
{
    return x < min ? min : ((x > max) ? max : x)
}

func createBitmapContext(w: Int, _ h: Int) -> CGContext
{
    let scaleFactor = screenFactor()
    let width = Int(CGFloat(w) * scaleFactor)
    let height = Int(CGFloat(h) * scaleFactor)
    
    let colorSpace = CGColorSpaceCreateDeviceRGB()
    let bitmapInfo = CGBitmapInfo(rawValue: CGImageAlphaInfo.PremultipliedFirst.rawValue)
    let context = CGBitmapContextCreate(nil, width, height, 8, 0, colorSpace, bitmapInfo.rawValue)
    
    return context!
}

/** User preferences */

func savePreference(key: String, data: AnyObject?)
{
    NSUserDefaults.standardUserDefaults().setObject(data, forKey: key)
}

func removePreference(key: String)
{
    NSUserDefaults.standardUserDefaults().removeObjectForKey(key)
    NSUserDefaults.standardUserDefaults().synchronize()
}

func getPreference(key: String) -> AnyObject?
{
    if let data = NSUserDefaults.standardUserDefaults().objectForKey(key) {
        return data
    }
    
    return [String: AnyObject]() as AnyObject?
}