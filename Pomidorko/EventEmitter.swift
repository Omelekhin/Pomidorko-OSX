//
//  EventEmitter.swift
//  Pomidorko
//
//  Created by Volter on 04.11.15.
//  Copyright © 2015 volter9. All rights reserved.
//

import Cocoa

class EventEmitter<T>
{
    var observers = [String: Observer<T, Void>]()
    
    func add(key: String, closure: T -> Void)
    {
        if observers[key] == nil {
            observers[key] = Observer<T, Void>()
        }
        
        observers[key]?.add(closure)
    }
    
    func emit(key: String, arg: T)
    {
        if observers[key] == nil {
            return
        }
        
        observers[key]?.invoke(arg)
    }
}
