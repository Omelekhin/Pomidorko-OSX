//
//  Observers.swift
//  Pomidorko
//
//  Created by Volter on 27.10.15.
//  Copyright (c) 2015 volter9. All rights reserved.
//

import Cocoa

class Observer<T, R>
{
    var observers = Array<T -> R>()
    
    func add(callback: T -> R)
    {
        observers.append(callback)
    }
    
    func invoke(arg: T)
    {
        for observer in observers {
            let closure = observer as T -> R
            
            closure(arg)
        }
    }
}
