//
//  Settings.swift
//  Pomidorko
//
//  Created by Volter on 31.10.15.
//  Copyright © 2015 volter9. All rights reserved.
//

import Cocoa

class Settings: Model
{
    override init(data: [String: AnyObject?])
    {
        let defaults: [String: AnyObject?] = [
            "shortBreak": 5,
            "longBreak": 20,
            "time": 25,
            
            "round": 4,
            "total": 12,
            
            "sound": true,
            "tick":  false
        ]
        
        super.init(data: mergeDict(defaults, second: data))
    }
}