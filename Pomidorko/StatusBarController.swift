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
    @IBOutlet var statusMenu: NSMenu?
    var statusBar: NSStatusItem?
    
    var goals: Goals
    var timer: Timer
    var settings: Settings
    
    init(timer: Timer, goals: Goals, settings: Settings)
    {
        self.goals = goals
        self.timer = timer
        self.settings = settings
        
        super.init(nibName: nil, bundle: nil)!
        NSBundle.mainBundle()
                .loadNibNamed("StatusBarMenu", owner: self, topLevelObjects: nil)
        
        goals.observer.add({ (dict: KVDict) -> Void in
            self.renderPomodorosItem()
        })
        
        settings.observer.add({ (dict: KVDict) -> Void in
            self.renderDockItems()
        })
        
        timer.emitter.add("pause", closure: { (d: Double) -> Void in
            self.renderPlayPauseItem()
        })
        
        timer.emitter.add("start", closure: { (d: Double) -> Void in
            self.renderPlayPauseItem()
        })
        
        statusBar = createStatusBar()
        render()
        
        NSEvent.addLocalMonitorForEventsMatchingMask(.KeyDownMask, handler: { (event: NSEvent) -> NSEvent? in
            if event.keyCode == 100 && event.modifierFlags.rawValue == 9961768 {
                self.toggleTimer(nil)
            }
            
            return event
        })
        
        NSEvent.addGlobalMonitorForEventsMatchingMask(.KeyDownMask, handler: { (event: NSEvent) -> Void in
            if event.keyCode == 100 && event.modifierFlags.rawValue == 9961768 {
                self.toggleTimer(nil)
            }
        })
    }

    required init?(coder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func createStatusBar() -> NSStatusItem
    {
        let statusItem = NSStatusBar.systemStatusBar()
            .statusItemWithLength(NSVariableStatusItemLength)
        
        let statusView = StatusBar(frame: NSMakeRect(0, 0, 72, 22))
        statusView.statusItem = statusItem
        statusItem.menu = statusMenu
        statusItem.view = statusView
        
        view = statusView
        return statusItem
    }
    
    func render()
    {
        renderPomodorosItem()
        renderPlayPauseItem()
        renderSkipItem()
        renderDockItems()
    }
    
    func renderPomodorosItem()
    {
        let current = goals.get("current") as! Int
        let pomodoros = String(
            format: localeString("n-pomodoro"),
            arguments: [timeOrdinal(current)]
        )
        
        statusMenu?.itemAtIndex(0)?.title = pomodoros
    }
    
    func renderPlayPauseItem()
    {
        statusMenu?.itemAtIndex(2)?.title = localeString(
            timer.isRunning() == true ? "pause" : "play"
        )
    }
    
    func renderSkipItem()
    {
        let isBreak = goals.get("recess") as! Bool
        
        statusMenu?.itemAtIndex(3)?.title = localeString(
            isBreak == true ? "skip-break" : "skip-pomodoro"
        )
    }
    
    func renderDockItems()
    {
        let isDockHidden = settings.get("dock") as! Bool
        
        for i in 6..<11 {
            statusMenu?.itemAtIndex(i)?.hidden = isDockHidden
        }
    }
    
    /**
     * Menu actions
     */
    
    @IBAction func toggleTimer(sender: AnyObject?)
    {
        let timer = AppDelegate.timer
        
        if timer?.isRunning() == true {
            AppDelegate.timer?.pause()
        }
        else {
            AppDelegate.timer?.start()
        }
    }
    
    @IBAction func skipTimer(sender: AnyObject?)
    {
        AppDelegate.timer?.stop()
    }
    
    @IBAction func openTimer(sender: AnyObject?)
    {
        AppDelegate.openTimer()
    }
    
    @IBAction func quitApp(sender: AnyObject?)
    {
        NSApp.terminate(nil)
    }
    
    @IBAction func openPreferences(sender: AnyObject?)
    {
        AppDelegate.openPreferences()
    }
    
    @IBAction func openAbout(sender: AnyObject?)
    {
        AppDelegate.openAbout()
    }
}