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
    override init(data: KVDict)
    {
        let defaults: KVDict = [
            "time": 25,
            "shortBreak": 5,
            "longBreak": 20,
            
            "round": 4,
            "total": 12,
            
            "sound": true,
            "tick":  false,

            "dock": false
        ]
        
        super.init(data: defaults.merge(data))
    }
}