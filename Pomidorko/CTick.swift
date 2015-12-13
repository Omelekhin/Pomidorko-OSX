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
        let url = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("tick", ofType: "mp3")!)
        
        self.timer = timer
        
        do {
            self.sound = try AVAudioPlayer(contentsOfURL: url)
            self.sound?.prepareToPlay()
        }
        catch {
            print("Error loading bell sound!")
        }
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
