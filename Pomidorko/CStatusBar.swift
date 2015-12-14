//
//  CStatusBar.swift
//  Pomidorko
//
//  Created by Volter on 13.12.15.
//  Copyright © 2015 volter9. All rights reserved.
//

import Cocoa

class CStatusBar: NSObject, Component
{
    var statusBar: StatusBar?
    var timer: Timer?
    
    init(timer: Timer?, statusBar: StatusBar?)
    {
        super.init()
        
        self.timer = timer
        self.statusBar = statusBar
        
        NSDistributedNotificationCenter.defaultCenter().addObserver(
            self,
            selector: "detectMode",
            name: "AppleInterfaceThemeChangedNotification",
            object: nil
        )
        
        detectMode()
    }
    
    func detectMode()
    {
        statusBar?.color = NSColor.textColor()
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
        let segment = time / Double((timer?.duration)!)
        
        statusBar?.render(segment, title: timeString(time))
    }
}