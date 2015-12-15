//
//  CControl.swift
//  Pomidorko
//
//  Created by Volter on 07.11.15.
//  Copyright © 2015 volter9. All rights reserved.
//

import Cocoa

class CControl: Component
{
    var timer: Timer?
    var control: PlayPause?
    
    init(timer: Timer?, control: PlayPause?)
    {
        self.timer = timer
        self.control = control
    }
    
    func activate()
    {
        let closure = { (time: Double) -> Void in
            self.render(!(self.timer?.isRunning())!)
        }
        
        timer?.emitter.add("stop", closure: closure)
        timer?.emitter.add("pause", closure: closure)
        timer?.emitter.add("start", closure: closure)
        
        render(true)
    }
    
    func toggle()
    {
        let state = timer?.isRunning()
        
        if state == true {
            timer?.pause()
        }
        else {
            timer?.start()
        }
    }
    
    func render(toggle: Bool)
    {
        control?.state = toggle.toInt()
        control?.setNeedsDisplay()
    }
}
