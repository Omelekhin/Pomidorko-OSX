//
//  Dictionary.swift
//  Pomidorko
//
//  Created by Volter on 27.10.15.
//  Copyright (c) 2015 volter9. All rights reserved.
//

import Foundation

func mergeDict <K, V> (first: Dictionary<K, V>, second: Dictionary<K, V>)
    -> Dictionary<K, V>
{
    var output = Dictionary<K, V>()
    
    for (key, value) in first {
        output.updateValue(value, forKey: key)
    }
    
    for (key, value) in second {
        output.updateValue(value, forKey: key)
    }
    
    return output
}