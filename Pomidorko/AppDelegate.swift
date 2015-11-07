//
//  AppDelegate.swift
//  Pomidorko
//
//  Created by Volter on 28.09.15.
//  Copyright (c) 2015 volter9. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate
{
    static var settings: Settings?
    static var timer: Timer?
    static var goals: Goals?
    
    override init()
    {
        super.init()
        
        AppDelegate.settings = Settings(data: Dictionary<String, AnyObject?>())
        AppDelegate.timer = Timer()
        AppDelegate.goals = Goals(data: Dictionary<String, AnyObject?>())
    }
}