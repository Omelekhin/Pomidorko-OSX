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
    
    static var timerWindow: NSWindow?
    
    static var settings: Settings?
    static var timer: Timer?
    static var goals: Goals?
    static var statusBar: StatusBar?
    
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
        AppDelegate.statusBar = createMenuItem()
    }
    
    func applicationShouldHandleReopen(sender: NSApplication, hasVisibleWindows flag: Bool) -> Bool
    {
        if let window = AppDelegate.timerWindow {
            window.makeKeyAndOrderFront(nil)
        }
        
        return true
    }
    
    func createMenuItem() -> StatusBar
    {
        let menu = NSMenu()
        
        menu.addItemWithTitle("Test", action:"test", keyEquivalent: "")
        statusItem = NSStatusBar.systemStatusBar()
            .statusItemWithLength(NSVariableStatusItemLength)
        
        let statusView = StatusBar(frame: NSMakeRect(0, 0, 72, 18))
        statusView.statusItem = statusItem
        
        statusItem?.highlightMode = true
        statusItem?.menu = menu
        statusItem?.view = statusView
        
        return statusView
    }
}