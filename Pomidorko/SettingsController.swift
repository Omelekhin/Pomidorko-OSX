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
    var controls: [AnyObject] = []
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
        view.window?.canHide = false
        
        initControls()
        
        for value in view.subviews {
            if (value.tag > 0) {
                controls.append(value as! NSControl)
            }
        }
        
        /**
         * Train your programming (O)OP skills with refactoring this code snippet
         */
        controls.sortInPlace({ (a, b) -> Bool in
            if a is SettingsField && b is NSButton {
                return (a as! SettingsField).tag < (b as! NSButton).tag
            }
            
            if a is NSButton && b is NSButton {
                return (a as! NSButton).tag < (b as! NSButton).tag
            }
            
            if a is SettingsField && b is SettingsField {
                return (a as! SettingsField).tag < (b as! SettingsField).tag
            }
            
            if a is NSButton && b is SettingsField {
                return (a as! NSButton).tag < (b as! SettingsField).tag
            }
            
            return false
        })
        
        setupFocus()
        fillSettings()
    }
    
    func initControls()
    {
        for value in view.subviews {
            if (value.tag > 0 && value.tag <= 5) {
                let suffix = value.tag > 3 ? "" : localeString("min")
                
                controls.append(
                    createControl(
                        Int(value.frame.origin.x),
                        Int(value.frame.origin.y) - 7,
                        value.tag,
                        suffix
                    )
                )
                
                value.removeFromSuperview()
            }
        }
    }
    
    func createControl(x: Int, _ y: Int, _ tag: Int, _ suffix: String) -> SettingsField
    {
        let control = SettingsField()
        
        switch tag {
            case 1: control.max = 55; break;
            case 2: control.max = 20; break;
            case 3: control.max = 45; break;
            default: break;
        }
        
        control.move(x, y: y)
        control.tag = tag
        control.setupSuffix(suffix)
        
        control.targetObj = self
        control.actionObj = "update:"
        
        view.addSubview(control.view)
        
        return control
    }
    
    func setupFocus()
    {
        view.window?.initialFirstResponder = (controls[0] as! SettingsField).input
        
        // Дикий костыль
        (controls[0] as! SettingsField).input?.nextKeyView = (controls[1] as! SettingsField).input
        (controls[1] as! SettingsField).input?.nextKeyView = (controls[2] as! SettingsField).input
        (controls[2] as! SettingsField).input?.nextKeyView = (controls[3] as! SettingsField).input
        (controls[3] as! SettingsField).input?.nextKeyView = (controls[4] as! SettingsField).input
        (controls[4] as! SettingsField).input?.nextKeyView = (controls[5] as! NSButton)
        (controls[5] as! NSButton).nextKeyView = (controls[6] as! NSButton)
        (controls[6] as! NSButton).nextKeyView = (controls[7] as! NSButton)
        (controls[7] as! NSButton).nextKeyView = (controls[0] as! SettingsField).input
    }
    
    func fillSettings()
    {
        let settings = AppDelegate.settings
        
        for control in controls {
            if control is SettingsField {
                let field = control as! SettingsField
                let key = map[field.tag]!
                
                field.setValue(settings?.get(key) as! Int)
            }
            else if control is NSButton {
                let button = control as! NSButton
                let key = map[button.tag]!
                
                button.state = (settings?.get(key) as! Bool).toInt()
                button.target = self
                button.action = "update:"
            }
        }
    }
    
    func update(sender: AnyObject)
    {
        let settings = AppDelegate.settings
        
        if sender is SettingsField {
            let field = sender as! SettingsField
            let key = map[field.tag]!
            
            settings?.set(key, value: field.getValue())
        }
        else if sender is NSButton {
            let button = sender as! NSButton
            let key = map[button.tag]!
            
            settings?.set(key, value: Bool(button.state))
        }
    }
}