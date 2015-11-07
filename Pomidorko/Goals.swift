//
//  Goals.swift
//  Pomidorko
//
//  Created by Volter on 05.11.15.
//  Copyright © 2015 volter9. All rights reserved.
//

import Cocoa

class Goals: Model
{
    override init(data: [String: AnyObject?])
    {
        let defaults: [String: AnyObject?] = [
            "remained": 0.0,
            "current":  0,
            "recess":   false,
            "start":    now()
        ]
        
        super.init(data: mergeDict(defaults, second: data))
    }
}
