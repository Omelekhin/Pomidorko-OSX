//
//  CScale.swift
//  Pomidorko
//
//  Created by Volter on 06.11.15.
//  Copyright © 2015 volter9. All rights reserved.
//

import Cocoa

class CScale: Component
{
    var scale: Scale?
    var timer: Timer?
    
    init(timer: Timer?, scale: Scale?)
    {
        self.scale = scale
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
        scale?.moveCursor(time)
    }
}
