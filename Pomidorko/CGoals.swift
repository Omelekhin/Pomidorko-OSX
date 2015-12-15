//
//  Goals.swift
//  Pomidorko
//
//  Created by Volter on 03.11.15.
//  Copyright © 2015 volter9. All rights reserved.
//

import Cocoa

class CGoals: Component
{
    var goalsField: NSTextField?
    var goalsModel: Goals?
    var settingsModel: Settings?
    
    init(
        field: NSTextField?,
        goals: Goals?,
        settings: Settings?
    ) {
        goalsField = field
        goalsModel = goals
        settingsModel = settings
    }
    
    func activate()
    {
        let closure = { (dict: KVDict) -> Void in
            self.render()
        }
        
        goalsModel?.observer.add(closure)
        settingsModel?.observer.add(closure)
        
        render()
    }
    
    func render()
    {
        let goals = goalsModel?.get("current") as! Int
        let total = settingsModel?.get("total") as! Int
        
        let title = String(format: localeString("goals"), arguments: [goals, total])
        let goalTitle = NSMutableAttributedString(string: title)
        let goalsOffset = String(goals).characters.count
        
        increase(goalTitle,
            font: NSFont.systemFontOfSize(14),
            offset: 0,
            length: title.characters.count
        )
        
        increase(goalTitle,
            font: NSFont.systemFontOfSize(28),
            offset: 0,
            length: goalsOffset
        )
        
        align(goalTitle, alignment: NSCenterTextAlignment)
        goalsField?.attributedStringValue = goalTitle
    }
}
