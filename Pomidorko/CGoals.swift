//
//  Goals.swift
//  Pomidorko
//
//  Created by Volter on 03.11.15.
//  Copyright © 2015 volter9. All rights reserved.
//

import Cocoa

class CGoals: NSObject, Component
{
    var goalsField: NSTextField?
    var goalsModel: Model?
    
    var goals: Int = 10
    var total: Int = 12
    
    init(goals: NSTextField?)
    {
        goalsField = goals
    }
    
    func activate()
    {
        self.render()
    }
    
    func render()
    {
        let title = String(
            format: localeString("goals"),
            arguments: [goals, total]
        )
        
        let goalTitle = NSMutableAttributedString(
            string: title
        )
        
        let goalsOffset = String(goals).characters.count
        let totalOffset = String(total).characters.count
        let range = Int(localeString("second-index"))!
        
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
        
        increase(goalTitle,
            font: NSFont.systemFontOfSize(20),
            offset: goalsOffset + range,
            length: totalOffset
        )
        
        align(goalTitle, alignment: NSCenterTextAlignment)
        goalsField?.attributedStringValue = goalTitle
    }
}
