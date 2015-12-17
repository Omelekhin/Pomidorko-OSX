//
//  StatusBarController.swift
//  Pomidorko
//
//  Created by Volter on 14.12.15.
//  Copyright © 2015 volter9. All rights reserved.
//

import Cocoa

class StatusBarController: NSViewController
{
    var statusMenu: NSMenu?
    var statusBar: NSStatusItem?
    
    var goals: Goals
    var timer: Timer
    
    init(goals: Goals, timer: Timer)
    {
        self.goals = goals
        self.timer = timer
        
        super.init(nibName: nil, bundle: nil)!
        
        goals.observer.add({ (dict: KVDict) -> Void in
            self.render()
        })
        
        timer.emitter.add("pause", closure: { (d: Double) -> Void in
            self.render()
        })
        
        timer.emitter.add("start", closure: { (d: Double) -> Void in
            self.render()
        })
        
        statusBar = createStatusBar()
        render()
    }

    required init?(coder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func createStatusBar() -> NSStatusItem
    {
        createMenu()
        
        let statusItem = NSStatusBar.systemStatusBar()
            .statusItemWithLength(NSVariableStatusItemLength)
        
        let statusView = StatusBar(frame: NSMakeRect(0, 0, 72, 22))
        statusView.statusItem = statusItem
        
        statusItem.menu = statusMenu
        statusItem.view = statusView
        
        view = statusView
        
        return statusItem
    }
    
    func createMenu()
    {
        statusMenu = NSMenu()
        statusMenu?.addItemWithTitle("", action:"", keyEquivalent: "")
        statusMenu?.addItem(NSMenuItem.separatorItem())
        statusMenu?.addItemWithTitle("", action: "toggleTimer", keyEquivalent: "")
        statusMenu?.addItemWithTitle("", action: "skipTimer", keyEquivalent: "")
        statusMenu?.addItem(NSMenuItem.separatorItem())
        statusMenu?.addItemWithTitle("", action: "openTimer", keyEquivalent: "")
        
        for (_, item) in (statusMenu?.itemArray.enumerate())! {
            (item as NSMenuItem).target = self
        }
    }
    
    func render()
    {
        let current = goals.get("current") as! Int
        let pomodoros = String(
            format: localeString("n-pomodoro"),
            arguments: [timeOrdinal(current)]
        )
        
        let isBreak = goals.get("recess") as! Bool
        
        statusMenu?.itemAtIndex(0)?.title = pomodoros
        statusMenu?.itemAtIndex(2)?.title = localeString(
            timer.isRunning() == true ? "pause" : "play"
        )
        statusMenu?.itemAtIndex(3)?.title = localeString(
            isBreak == true ? "skip-break" : "skip-pomodoro"
        )
        statusMenu?.itemAtIndex(5)?.title = localeString("open-timer")
    }
    
    /**
     * Menu actions
     */
    
    func toggleTimer()
    {
        let timer = AppDelegate.timer
        
        if timer?.isRunning() == true {
            AppDelegate.timer?.pause()
        }
        else {
            AppDelegate.timer?.start()
        }
    }
    
    func skipTimer()
    {
        AppDelegate.timer?.stop()
    }
    
    func openTimer()
    {
        AppDelegate.openTimer()
        NSApp.activateIgnoringOtherApps(true)
    }
}