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
    
    init(
        button: NSButton?,
        goals: Goals?
    ) {
        skipButton = button
        goalsModel = goals
    }
    
    func activate()
    {   
        renderTitle()
    }
    
    func skip()
    {
        let current = goalsModel?.get("current") as! Int
        
        goalsModel?.set("current", value: current + 1)
    }
    
    func renderTitle()
    {
        skipButton?.attributedTitle = colorize(
            skipButton?.attributedTitle, color: WhiteColor
        )
    }
}
