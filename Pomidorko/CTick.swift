//
//  CTick.swift
//  Pomidorko
//
//  Created by Volter on 12.12.15.
//  Copyright © 2015 volter9. All rights reserved.
//

import Cocoa
import AVFoundation

class CTick: Component
{
    var time: Int = -1
    var timer: Timer?
    var sound: AVAudioPlayer?
    var settings: Settings?
    var enabled: Bool = false
    
    init(timer: Timer?, settings: Settings?)
    {
        self.timer = timer
        self.sound = getSound("tick")
        self.settings = settings
    }
    
    func activate()
    {
        settings?.observer.add({ (dict: KVDict) -> Void in
            self.toggle()
        })
        
        timer?.emitter.add("tick", closure: { (time: Double) -> Void in
            if self.enabled == true {
                self.tick(time)
            }
        })
        
        toggle()
    }
    
    func toggle()
    {
        enabled = self.settings?.get("tick") as! Bool
    }
    
    func tick(time: Double)
    {
        let d: Int = Int(time)
        
        if d != self.time  {
            self.sound?.stop()
            self.sound?.prepareToPlay()
            self.sound?.play()
        }
        
        self.time = d
    }
}
