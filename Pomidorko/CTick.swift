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
    
    init(timer: Timer?)
    {
        self.timer = timer
        self.sound = getSound("tick")
    }
    
    func activate()
    {
        timer?.emitter.add("tick", closure: { (time: Double) -> Void in
            self.tick(time)
        })
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
