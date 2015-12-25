//
//  ViewController.swift
//  Pomidorko
//
//  Created by Volter on 28.09.15.
//  Copyright (c) 2015 volter9. All rights reserved.
//

import Cocoa

class ViewController: NSViewController
{
    @IBOutlet weak var skip: HoverableButton?
    @IBOutlet weak var time: NSTextField?
    @IBOutlet weak var goalsField: NSTextField?
    @IBOutlet weak var control: PlayPause?
    @IBOutlet weak var scale: Scale?
    
    var components: [String: Component]?
    var initialized: Bool = false
    
    override func viewDidAppear()
    {
        if (initialized) {
            return
        }
        
        super.viewDidAppear()
        
        AppDelegate.timerWindow = view.window
        flatify(view.window!, color: BlueColor)
        view.window?.makeFirstResponder(nil)
        
        skip?.cursor = NSCursor.pointingHandCursor()
        control?.cursor = NSCursor.pointingHandCursor()
        
        initComponents()
        initialized = true
    }
    
    func initComponents()
    {
        let timer = AppDelegate.timer
        let goals = AppDelegate.goals
        let settings = AppDelegate.settings
        
        CState(
            timer: timer,
            goals: goals, 
            settings: settings,
            control: control,
            window: view.window
        ).activate()
        
        components = [
            "control": CControl(timer: timer, control: control),
            "status":  CStatusBar(timer: timer, statusBar: AppDelegate.statusBar, goals: goals, settings: settings),
            "goals":   CGoals(field: goalsField, goals: goals, settings: settings),
            "scale":   CScale(timer: timer, scale: scale, settings: settings),
            "sound":   CSound(timer: timer, settings: settings),
            "tick":    CTick(timer: timer, settings: settings),
            "skip":    CSkip(button: skip, goals: goals, timer: timer),
            "time":    CTime(label: time, timer: timer, settings: settings),
            "icon":    CIcon(settings: settings)
        ]
        
        for (_, component) in components! {
            component.activate()
        }
    }
    
    /**
     * IB actions, because I didn't found other way to attach UI events to 
     * component objects, such a shame
     */
    
    @IBAction func skip(sender: AnyObject?)
    {
        (components!["skip"] as! CSkip).skip()
    }
    
    @IBAction func playPause(sender: AnyObject?)
    {
        (components!["control"] as! CControl).toggle()
    }
}