//
//  AppDelegate.swift
//  Pomidorko
//
//  Created by Volter on 28.09.15.
//  Copyright (c) 2015 volter9. All rights reserved.
//

import Cocoa

func resetToday(time: Double, _ start: Double) -> Bool
{
    let twoDays: Double = 60 * 60 * 24 * 2

    let dateStart = NSDate(timeIntervalSince1970: start)
    let dateNow   = NSDate(timeIntervalSince1970: time)
    
    return (dateDay(dateNow) != dateDay(dateStart)
        && dateHour(dateNow) >= 6) || time - start > twoDays
}

func resetAtMorning()
{
    let goals = getPreference("goals") as! KVDict
    
    if let start = goals["start"] {
        if resetToday(now(), start as! Double) {
            removePreference("goals")
        }
    }
}

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate
{
    var statusItem: NSStatusItem?
    var statusController: StatusBarController
    
    static var timerWindow: NSWindow?
    static var preferences: NSWindowController?
    static var about: NSWindowController?
    
    static var settings: Settings?
    static var timer: Timer?
    static var goals: Goals?
    static var statusBar: StatusBar?
    
    override init()
    {
        resetAtMorning()
        
        let timer = Timer()
        let goals = Goals(data: getPreference("goals") as! KVDict)
        let settings = Settings(data: getPreference("settings") as! KVDict)
        
        statusController = StatusBarController(
            timer: timer,
            goals: goals,
            settings: settings
        )
        
        super.init()
        
        goals.observer.add({ (dict: KVDict) -> Void in
            savePreference("goals", data: dict as AnyObject?)
        })
        
        settings.observer.add({ (dict: KVDict) -> Void in
            savePreference("settings", data: dict as AnyObject?)
        })
        
        AppDelegate.timer = timer
        AppDelegate.goals = goals
        AppDelegate.settings = settings
        AppDelegate.statusBar = statusController.view as? StatusBar
    }
    
    /**
     * Menu actions
     */
    
    @IBAction func openAbout(sender: AnyObject?)
    {
        AppDelegate.openAbout()
    }
    
    @IBAction func openPreferences(sender: AnyObject?)
    {
        AppDelegate.openPreferences()
    }
    
    /**
     * App delegate methods
     */
    
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
    
    /**
     * Global window openers
     */
    
    internal class func openTimer()
    {
        if let window = AppDelegate.timerWindow {
            window.makeKeyAndOrderFront(nil)
        }
        
        NSApp.activateIgnoringOtherApps(true)
    }
    
    internal class func openPreferences()
    {
        if AppDelegate.preferences == nil {
            AppDelegate.preferences = AppDelegate.createController("preferences")
        }
        
        AppDelegate.preferences?.showWindow(nil)
        NSApp.activateIgnoringOtherApps(true)
    }
    
    internal class func openAbout()
    {
        if AppDelegate.about == nil {
            AppDelegate.about = AppDelegate.createController("about")
        }
        
        AppDelegate.about?.showWindow(nil)
        NSApp.activateIgnoringOtherApps(true)
    }
    
    internal class func createController(key: String) -> NSWindowController
    {
        let storyBoard = NSStoryboard(name: "Main", bundle: nil)
        
        return storyBoard.instantiateControllerWithIdentifier(key) as! NSWindowController
    }
}