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
    var settings: Settings?
    
    init(timer: Timer?, scale: Scale?, settings: Settings?)
    {
        self.scale = scale
        self.timer = timer
        self.settings = settings
    }
    
    func activate()
    {
        timer?.emitter.add("tick", closure: { (time: Double) -> Void in
            self.render(time)
        })
        
        settings?.observer.add({ (dict: KVDict) -> Void in
            if self.timer!.isClean() {
                self.render((self.timer?.time())!)
            }
        })
        
        render((timer?.time())!)
    }
    
    func render(time: Double)
    {
        scale?.moveCursor(time)
    }
}
