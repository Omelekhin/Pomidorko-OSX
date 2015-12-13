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
        let title = timeString(time)
        let attributed = NSMutableAttributedString(string: title)
        
        increase(attributed, font: timeFont(72), offset: 0, length: title.characters.count)
        align(attributed, alignment: NSCenterTextAlignment)
        
        label?.attributedStringValue = attributed
    }
}
