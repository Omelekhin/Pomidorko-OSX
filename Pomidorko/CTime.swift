//
//  CTime.swift
//  Pomidorko
//
//  Created by Volter on 06.11.15.
//  Copyright © 2015 volter9. All rights reserved.
//

import Cocoa

class CTime: Component
{
    var label: NSTextField?
    var timer: Timer?
    
    init(label: NSTextField?, timer: Timer?)
    {
        self.label = label
        self.timer = timer
    }
    
    func activate()
    {
        timer?.emitter.add("tick", closure: { (time: Double) -> Void in
            self.render(time)
        })
        
        render((timer?.time())!)
    }
    
    func render(time: Double)
    {
        let min = Int(time / 60)
        let sec = Int(time % 60)
        
        let title = pad(String(min), subject: "00") + ":" + pad(String(sec), subject: "00")
        let attributed = NSMutableAttributedString(string: title)
        
        var font: NSFont
        
        if #available(OSX 10.11, *) {
            font = NSFont.monospacedDigitSystemFontOfSize(72, weight: NSFontWeightUltraLight)
        }
        else {
            font = NSFont(name: "LatoUltraLight", size: 72)!
        }
        
        increase(
            attributed,
            font: font,
            offset: 0,
            length: title.characters.count
        )
        
        align(attributed, alignment: NSCenterTextAlignment)
        
        label?.attributedStringValue = attributed
    }
}
