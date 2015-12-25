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
    var goals: Goals?
    var settings: Settings?
    
    init(timer: Timer?, statusBar: StatusBar?, goals: Goals?, settings: Settings?)
    {
        super.init()
        
        self.timer = timer
        self.statusBar = statusBar
        self.goals = goals
        self.settings = settings
        
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
        
        timer?.emitter.add("start", closure: { (time: Double) -> Void in
            self.setupAlpha()
        })
        
        settings?.observer.add({ (dict: KVDict) -> Void in
            if self.timer!.isClean() {
                self.render((self.timer?.time())!)
            }
        })
        
        setupAlpha()
        render((timer?.time())!)
    }
    
    func setupAlpha()
    {
        let recess = self.goals!.get("recess") as! Bool
        
        self.statusBar?.alpha = recess == true ? 0.5 : 1
    }
    
    func render(time: Double)
    {
        let segment = time / Double((timer?.duration)!)
        
        statusBar?.render(segment, title: timeString(time))
    }
}