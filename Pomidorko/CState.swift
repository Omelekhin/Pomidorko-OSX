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
            
            return
        })
        
        render(
            goalsModel?.get("recess") as! Bool, 
            goalsModel?.get("current") as! Int
        )
    }
    
    func next()
    {
        print(goalsModel?.data)
        
        let recess = !(goalsModel?.get("recess") as! Bool)
        let current = (goalsModel?.get("current") as! Int) + recess.toInt()
        
        let values: [String: AnyObject?] = [
            "recess": recess,
            "current": current
        ]
        
        goalsModel?.merge(values)
        
        setTime(recess, current)
        render(recess, current)
    }
    
    func setTime(recess: Bool, _ current: Int)
    {
        let shortBreak = settingsModel?.get("shortBreak") as! Int
        let longBreak = settingsModel?.get("longBreak") as! Int
        let time = settingsModel?.get("time") as! Int
        
        let round = settingsModel?.get("round") as! Int
        
        var duration: Int
        
        if recess == true {
            duration = current % round == 0 ? longBreak : shortBreak
        }
        else {
            duration = time
        }
        
        timer?.duration = duration * 60
        timer?.start()
    }
    
    func render(recess: Bool, _ current: Int)
    {
        window?.backgroundColor  = recess == true ? BlueColor : RedColor
        control?.backgroundColor = recess == true ? LightBlueColor : LightRedColor
        control?.setNeedsDisplay()
    }
}