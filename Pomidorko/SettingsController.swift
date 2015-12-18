//
//  SettingsController.swift
//  Pomidorko
//
//  Created by Volter on 15.12.15.
//  Copyright © 2015 volter9. All rights reserved.
//

import Cocoa

class SettingsController: NSViewController
{
    var controls: [NSView] = []
    var map: [Int: String] = [
        1: "time",
        2: "shortBreak",
        3: "longBreak",
        4: "round",
        5: "total",
        6: "sound",
        7: "tick",
        8: "dock"
    ]
    
    override func viewDidAppear()
    {
        super.viewDidAppear()
        
        flatify(view.window!, color: LightGreyColor)
        view.window?.makeFirstResponder(nil)
        
        for value in view.subviews {
            if (value.tag > 0) {
                controls.append(value)
            }
        }
        
        fillSettings()
    }
    
    func fillSettings()
    {
        let settings = AppDelegate.settings
        
        for control in controls {
            let key = map[control.tag]!
            
            if control is NSTextField {
                let field = control as! NSTextField
                
                field.intValue = Int32(settings?.get(key) as! Int)
                field.target = self
                field.action = "update:"
            }
            else {
                let button = control as! NSButton
                
                button.state = (settings?.get(key) as! Bool).toInt()
                button.target = self
                button.action = "update:"
            }
        }
    }
    
    func update(sender: NSView)
    {
        let key = map[sender.tag]!
        let settings = AppDelegate.settings
        
        if sender is NSTextField {
            let field = sender as! NSTextField
            
            settings?.set(key, value: Int(field.intValue))
        }
        else {
            let button = sender as! NSButton
            
            settings?.set(key, value: Bool(button.state))
        }
    }
}