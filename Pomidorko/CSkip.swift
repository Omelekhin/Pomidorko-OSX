//
//  CSkip.swift
//  Pomidorko
//
//  Created by Volter on 05.11.15.
//  Copyright © 2015 volter9. All rights reserved.
//

import Cocoa

class CSkip: NSObject, Component
{
    var skipButton: NSButton?
    var goalsModel: Goals?
    var timer: Timer?
    
    init(
        button: NSButton?,
        goals: Goals?,
        timer: Timer?
    ) {
        skipButton = button
        goalsModel = goals
        self.timer = timer
    }
    
    func activate()
    {
        timer?.emitter.add("stop", closure: { (d: Double) -> Void  in
            self.renderTitle()
        })
        
        renderTitle()
    }
    
    func skip()
    {
        timer?.stop()
    }
    
    func renderTitle()
    {
        let recess = goalsModel?.get("recess") as! Bool
        let title = recess == true ? localeString("skip-break") 
                                   : localeString("skip-pomodoro")
        
        let attributed = NSMutableAttributedString(string: title)
        
        align(attributed, alignment: NSCenterTextAlignment)
        colorize(attributed, color: WhiteColor)
        
        skipButton?.attributedTitle = attributed
    }
}