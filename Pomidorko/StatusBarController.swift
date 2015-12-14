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
    
    init()
    {
        super.init(nibName: nil, bundle: nil)!
        
        statusBar = createStatusBar()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func createStatusBar() -> NSStatusItem
    {
        createMenu()
        
        let statusItem = NSStatusBar.systemStatusBar()
            .statusItemWithLength(NSVariableStatusItemLength)
        
        let statusView = StatusBar(frame: NSMakeRect(0, 0, 72, 18))
        statusView.statusItem = statusItem
        
        statusItem.menu = statusMenu
        statusItem.view = statusView
        
        view = statusView
        
        return statusItem
    }
    
    func createMenu()
    {
        statusMenu = NSMenu()
        statusMenu?.addItemWithTitle("10-я помидорка", action:"", keyEquivalent: "")
        statusMenu?.addItem(NSMenuItem.separatorItem())
        statusMenu?.addItemWithTitle("Пауза", action: "pauseTimer", keyEquivalent: "")
        statusMenu?.addItemWithTitle("Пропустить перерыв", action: "skipTimer", keyEquivalent: "")
        statusMenu?.addItem(NSMenuItem.separatorItem())
        statusMenu?.addItemWithTitle("Открыть таймер", action: "openTimer", keyEquivalent: "")
        
        for (_, item) in (statusMenu?.itemArray.enumerate())! {
            (item as NSMenuItem).target = self
        }
    }
    
    func pauseTimer()
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
    }
}
