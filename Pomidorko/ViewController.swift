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
    @IBOutlet weak var skip: NSButton?
    @IBOutlet weak var time: NSTextField?
    @IBOutlet weak var goalsField: NSTextField?
    @IBOutlet weak var control: PlayPause?
    
    var components: [String: Component]?
    
    override func viewDidAppear()
    {
        super.viewDidAppear()
        
        initView()
        initComponents()
    }
    
    func initView()
    {
        flatify(view.window!, color: BlueColor)
        
        control?.backgroundColor = LightBlueColor
    }
    
    func initComponents()
    {
        let goals = AppDelegate.goals
        let settings = AppDelegate.settings
        
        components = [
            "goals": CGoals(field: goalsField, goals: goals, settings: settings),
            "skip":  CSkip(button: skip, goals: goals)
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
}