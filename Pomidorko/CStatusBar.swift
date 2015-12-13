//
//  CStatusBar.swift
//  Pomidorko
//
//  Created by Volter on 13.12.15.
//  Copyright © 2015 volter9. All rights reserved.
//

import Cocoa

class CStatusBar: Component
{
    var statusBar: StatusBar?
    var timer: Timer?
    
    init(timer: Timer?, statusBar: StatusBar?)
    {
        self.statusBar = statusBar
        self.timer = timer
    }
    
    func activate()
    {
        timer?.emitter.add("tick", closure: { (time: Double) -> Void in
            self.render(time)
        })
        
        render(0)
    }
    
    func render(time: Double)
    {
        let segment = time / Double((timer?.duration)!)
        
        statusBar?.render(segment, title: timeString(time))
    }
}