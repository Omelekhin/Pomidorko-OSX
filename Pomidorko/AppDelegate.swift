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
    static var timerWindow: NSWindow?
    
    static var settings: Settings?
    static var timer: Timer?
    static var goals: Goals?
    
    override init()
    {
        super.init()
        
        let timer = Timer()
        let goals = Goals(data: KVDict())
        let settings = Settings(data: KVDict())
        
        goals.observer.add({ (dict: KVDict) -> Void in
            
        })
        
        settings.observer.add({ (dict: KVDict) -> Void in
            
        })
        
        AppDelegate.timer = timer
        AppDelegate.goals = goals
        AppDelegate.settings = settings
    }
    
    func applicationShouldHandleReopen(sender: NSApplication, hasVisibleWindows flag: Bool) -> Bool
    {
        if let window = AppDelegate.timerWindow {
            window.makeKeyAndOrderFront(nil)
        }
        
        return true
    }
    
    internal class func toggleDock()
    {
        NSApp.setActivationPolicy(.Accessory)
        NSApp.presentationOptions = .Default
    }
}