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
        if duration <= 0 || isRunning() {
            return
        }
        
        let dur = remained == 0 ? Double(duration) * 1000.0
                                : remained
        
        startTime = now() * 1000.0
        endTime = startTime + dur
        
        timer = NSTimer(
            timeInterval: 1 / 24,
            target: self,
            selector: "tick",
            userInfo: nil,
            repeats: true
        )
        
        NSRunLoop.mainRunLoop().addTimer(timer!, forMode:NSRunLoopCommonModes)
        
        emitter.emit("start", arg: dur / 1000.0)
    }
    
    func stop()
    {
        startTime = 0.0
        remained  = 0.0
        endTime   = 0.0
        
        timer?.invalidate()
        timer = nil
        
        emitter.emit("stop", arg: 0.0)
    }
    
    func pause()
    {
        if timer == nil {
            return
        }
        
        remained = endTime - now() * 1000.0
        
        timer?.invalidate()
        timer = nil
        
        emitter.emit("pause", arg: 0.0)
    }
    
    func tick()
    {
        var time = (endTime - now() * 1000.0) / 1000.0
        
        if time <= 0 {
            time = 0
            
            stop()
        }
        
        emitter.emit("tick", arg: time)
    }
    
    func time() -> Double
    {
        return remained > 0 ? remained / 1000.0
                            : Double(duration)
    }
    
    func isRunning() -> Bool
    {
        return timer != nil
    }
    
    func isClean() -> Bool
    {
        return !isRunning() && remained == 0
    }
}