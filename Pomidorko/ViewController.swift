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
    @IBOutlet weak var goals: NSTextField?
    @IBOutlet weak var control: PlayPause?
    
    var settings: Settings?
    
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
        skip?.attributedTitle = colorize(skip?.attributedTitle, color: WhiteColor)
    }
    
    func initComponents()
    {
        let components: Array<Component> = [
            CGoals(goals: goals)
        ]
        
        for component in components {
            component.activate()
        }
    }
}

