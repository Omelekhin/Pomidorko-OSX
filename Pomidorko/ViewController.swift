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
    
    override func viewDidAppear()
    {
        super.viewDidAppear()
        
        AppDelegate.timerWindow = view.window
        flatify(view.window!, color: BlueColor)
        
        skip?.cursor = NSCursor.pointingHandCursor()
        control?.cursor = NSCursor.pointingHandCursor()
        
        initComponents()
    }
    
    func initComponents()
    {
        let timer = AppDelegate.timer
        let goals = AppDelegate.goals
        let settings = AppDelegate.settings
        
        // Some unexaplainable shit
        // I need to debug this part of code
        // @todo debug
        // Some dark black magic shit
        CSound(timer: timer).activate()
        CTick(timer: timer).activate()
        
        components = [
            "state": CState(
                timer: timer, 
                goals: goals, 
                settings: settings,
                control: control,
                window: view.window
            ),
            "control": CControl(timer: timer, control: control),
            "status": CStatusBar(timer: timer, statusBar: AppDelegate.statusBar),
            "goals": CGoals(field: goalsField, goals: goals, settings: settings),
            "scale": CScale(timer: timer, scale: scale),
            "skip":  CSkip(button: skip, goals: goals, timer: timer),
            "time":  CTime(label: time, timer: timer),
        ]
        
        for (_, component) in components! {
            component.activate()
        }
    }
    
    /**
     * IB actions, didn't found other way to attach UI events to components
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