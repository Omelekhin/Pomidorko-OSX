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
            "longBreak": 10.0
        ]
        
        super.init()
        
        self.data = mergeDict(defaults, second: data)
    }
}
