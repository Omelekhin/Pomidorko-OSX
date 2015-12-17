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
    var goals: Goals?
    var settings: Settings?
    
    init(
        field: NSTextField?,
        goals: Goals?,
        settings: Settings?
    ) {
        goalsField = field
        self.goals = goals
        self.settings = settings
    }
    
    func activate()
    {
        let closure = { (dict: KVDict) -> Void in
            self.render()
        }
        
        goals?.observer.add(closure)
        settings?.observer.add(closure)
        
        render()
    }
    
    func render()
    {
        let goals = self.goals?.get("current") as! Int
        let total = settings?.get("total") as! Int
        
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
