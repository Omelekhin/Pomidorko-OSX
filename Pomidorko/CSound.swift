//
//  CSoundNotification.swift
//  Pomidorko
//
//  Created by Volter on 12.12.15.
//  Copyright © 2015 volter9. All rights reserved.
//

import Cocoa
import AVFoundation

class CSound: Component
{
    var timer: Timer?
    var sound: AVAudioPlayer?
    var settings: Settings?
    var enabled: Bool = false
    
    init(timer: Timer?, settings: Settings?)
    {
        self.timer = timer
        self.sound = getSound("bell")
        self.settings = settings
    }
    
    func activate()
    {
        settings?.observer.add({ (dict: KVDict) -> Void in
            self.toggle()
        })
        
        timer?.emitter.add("stop", closure: { (d: Double) -> Void in
            if self.enabled == true {
                self.beep()
            }
        })
        
        toggle()
    }
    
    func toggle()
    {
        enabled = settings?.get("sound") as! Bool
    }
    
    func beep()
    {
        self.sound?.stop()
        self.sound?.prepareToPlay()
        self.sound?.play()
    }
}
