//
//  Timer.swift
//  Pomidorko
//
//  Created by Volter on 04.11.15.
//  Copyright © 2015 volter9. All rights reserved.
//

import Cocoa

class Timer: NSObject
{
    var startTime: NSTimeInterval = 0
    var endTime:   NSTimeInterval = 0
    
    var remained: NSTimeInterval = 0
    var duration: Int = 0
    
    var timer: NSTimer?
    var emitter = EventEmitter<Double>()
    
    func start()
    {
        if self.duration <= 0 {
            return
        }
        
        startTime = now()
        endTime = startTime + (remained == 0 ? Double(duration) * 1000.0
                                             : remained)
        
        timer = NSTimer.scheduledTimerWithTimeInterval(
            1 / 24,
            target: self,
            selector: "tick",
            userInfo: nil,
            repeats: true
        )
        
        emitter.emit("start", arg: 0.0)
    }
    
    func stop()
    {
        startTime = 0.0
        remained  = 0.0
        endTime   = 0.0
        
        timer?.invalidate()
        
        emitter.emit("stop", arg: 0.0)
    }
    
    func pause()
    {
        remained = endTime - startTime
        
        timer?.invalidate()
    }
    
    func tick()
    {
        var time = (endTime - now()) / 1000.0
        
        if time <= 0 {
            time = 0
            
            stop()
        }
        
        emitter.emit("tick", arg: time)
    }
}
