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
    var statusItem: NSStatusItem?
    var statusController: StatusBarController
    
    static var timerWindow: NSWindow?
    
    static var settings: Settings?
    static var timer: Timer?
    static var goals: Goals?
    static var statusBar: StatusBar?
    
    override init()
    {
        statusController = StatusBarController()
        
        super.init()
        
        let timer = Timer()
        let goals = Goals(data: KVDict())
        let settings = Settings(data: KVDict())
        
        goals.observer.add({ (dict: KVDict) -> Void in
            // Add logic for persisting model to the disk
        })
        
        settings.observer.add({ (dict: KVDict) -> Void in
            // Add logic for persisting model to the disk
        })
        
        AppDelegate.timer = timer
        AppDelegate.goals = goals
        AppDelegate.settings = settings
        AppDelegate.statusBar = statusController.view as? StatusBar
    }
    
    func applicationShouldHandleReopen(sender: NSApplication, hasVisibleWindows flag: Bool) -> Bool
    {
        AppDelegate.openTimer()
        
        return true
    }
    
    internal class func toggleMenuItem(toggle: Bool)
    {
        AppDelegate.statusBar?.statusItem?.length = toggle == false ? 72 : 0
    }
    
    internal class func openTimer()
    {
        if let window = AppDelegate.timerWindow {
            window.makeKeyAndOrderFront(nil)
        }
    }
}