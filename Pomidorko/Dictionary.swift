//
//  Dictionary.swift
//  Pomidorko
//
//  Created by Volter on 27.10.15.
//  Copyright (c) 2015 volter9. All rights reserved.
//

import Foundation

typealias KVDict = Dictionary<String, AnyObject?>

extension Dictionary
{
    func merge(dict: Dictionary) -> Dictionary
    {
        var output = Dictionary()
    
        for (key, value) in self {
            output.updateValue(value, forKey: key)
        }
        
        for (key, value) in dict {
            output.updateValue(value, forKey: key)
        }
        
        return output
    }
}