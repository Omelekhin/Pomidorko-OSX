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
        let timer = Timer()
        let goals = Goals(data: getPreferences("goals") as! KVDict)
        let settings = Settings(data: getPreferences("settings") as! KVDict)
        
        statusController = StatusBarController(
            goals: goals, timer: timer
        )
        
        goals.observer.add({ (dict: KVDict) -> Void in
            savePreferences("goals", data: dict as AnyObject?)
        })
        
        settings.observer.add({ (dict: KVDict) -> Void in
            savePreferences("settings", data: dict as AnyObject?)
        })
        
        super.init()
        
        AppDelegate.timer = timer
        AppDelegate.goals = goals
        AppDelegate.settings = settings
        AppDelegate.statusBar = statusController.view as? StatusBar
    }
    
    func applicationWillTerminate(notification: NSNotification)
    {
        AppDelegate.timer?.pause()
        AppDelegate.goals?.set("remained", value: AppDelegate.timer?.time())
        
        NSUserDefaults.standardUserDefaults().synchronize()
    }
    
    func applicationShouldHandleReopen(sender: NSApplication, hasVisibleWindows flag: Bool) -> Bool
    {
        AppDelegate.openTimer()
        
        return true
    }
    
    internal class func openTimer()
    {
        if let window = AppDelegate.timerWindow {
            window.makeKeyAndOrderFront(nil)
        }
    }
}