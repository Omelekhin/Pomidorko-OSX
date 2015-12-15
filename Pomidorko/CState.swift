//
//  CState.swift
//  Pomidorko
//
//  Created by Volter on 06.11.15.
//  Copyright © 2015 volter9. All rights reserved.
//

import Cocoa

class CState: Component
{
    var timer: Timer?
    var goalsModel: Goals?
    var settingsModel: Settings?
    var control: PlayPause?
    var window: NSWindow?
    
    init(
        timer: Timer?, 
        goals: Goals?, 
        settings: Settings?,
        control: PlayPause?,
        window: NSWindow?
    ) {
        self.timer = timer
        goalsModel = goals
        settingsModel = settings
        self.control = control
        self.window = window
    }
    
    func activate()
    {
        timer?.emitter.add("stop", closure: {(d: Double) -> Void in
            self.next()
        })
        
        let recess = goalsModel?.get("recess") as! Bool
        let time = goalsModel?.get("current") as! Int
        
        setTime(recess, current: time)
        render(recess, current: time)
    }
    
    func next()
    {
        let recess = !(goalsModel?.get("recess") as! Bool)
        let current = (goalsModel?.get("current") as! Int) + recess.toInt()
        
        let values: KVDict = [
            "recess":  recess,
            "current": current
        ]
        
        goalsModel?.merge(values)
        
        setTime(recess, current: current)
        render(recess, current: current)
        
        timer?.start()
    }
    
    func setTime(recess: Bool, current: Int)
    {
        let shortBreak = settingsModel?.get("shortBreak") as! Int
        let longBreak = settingsModel?.get("longBreak") as! Int
        
        let time = settingsModel?.get("time") as! Int
        let round = settingsModel?.get("round") as! Int
        
        let duration: Int = recess == true
            ? (current % round == 0 ? longBreak : shortBreak)
            : time
        
        timer?.duration = duration * 60
    }
    
    func render(recess: Bool, current: Int)
    {
        window?.backgroundColor  = recess == true ? BlueColor : RedColor
        control?.backgroundColor = recess == true ? LightBlueColor : LightRedColor
        control?.setNeedsDisplay()
    }
}