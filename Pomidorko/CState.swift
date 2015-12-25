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
    var goals: Goals?
    var settings: Settings?
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
        self.goals = goals
        self.settings = settings
        self.control = control
        self.window = window
    }
    
    func activate()
    {
        timer?.emitter.add("stop", closure: {(d: Double) -> Void in
            self.next()
        })
        
        settings?.observer.add({ (dict: KVDict) -> Void in
            self.setCurrentTime()
        })
        
        let remained = goals?.get("remained") as! Double
        
        if remained > 0 {
            timer?.remained = remained * 1000
        }
        
        setCurrentTime()
    }
    
    func setCurrentTime()
    {
        let recess = goals?.get("recess") as! Bool
        let time = goals?.get("current") as! Int
        
        setTime(recess, current: time)
        render(recess, current: time)
    }
    
    func next()
    {
        let recess = !(goals?.get("recess") as! Bool)
        let current = (goals?.get("current") as! Int) + recess.toInt()
        
        let values: KVDict = [
            "recess":  recess,
            "current": current
        ]
        
        goals?.merge(values)
        
        setTime(recess, current: current)
        render(recess, current: current)
        
        timer?.start()
    }
    
    func setTime(recess: Bool, current: Int)
    {
        let shortBreak = settings?.get("shortBreak") as! Int
        let longBreak = settings?.get("longBreak") as! Int
        
        let time = settings?.get("time") as! Int
        let round = settings?.get("round") as! Int
        
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