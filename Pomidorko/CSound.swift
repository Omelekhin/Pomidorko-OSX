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
    
    init(timer: Timer?)
    {
        self.timer = timer
        self.sound = getSound("bell")
    }
    
    func activate()
    {
        timer?.emitter.add("stop", closure: { (d: Double) -> Void in
            self.beep()
        })
    }
    
    func beep()
    {
        self.sound?.stop()
        self.sound?.prepareToPlay()
        self.sound?.play()
    }
}
