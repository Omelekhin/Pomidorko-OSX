//
//  Model.swift
//  Pomidorko
//
//  Created by Volter on 27.10.15.
//  Copyright (c) 2015 volter9. All rights reserved.
//

import Cocoa

class Model
{
    var data: [String: AnyObject?]
    var observer = Observer<[String: AnyObject?], Void>()
    
    func set(key: String, value: AnyObject?)
    {
        data.updateValue(value, forKey: key)
        observer.invoke(data)
    }
    
    func get(key: String) -> AnyObject!
    {
        return data[key]!
    }
    
    init(data: [String: AnyObject?] = [String: AnyObject?]())
    {
        self.data = data
    }
}
