//
//  SettingsField.swift
//  Pomidorko
//
//  Created by Volter on 21.12.15.
//  Copyright © 2015 volter9. All rights reserved.
//

import Cocoa

class SettingsField: NSViewController
{
    @IBOutlet var increaseButton: NSButton?
    @IBOutlet var decreaseButton: NSButton?
    @IBOutlet var input: NSTextField?
    @IBOutlet var suffix: NSTextField?
    
    var targetObj: NSObject?
    var actionObj: Selector?
    var tag: Int = 0
    
    var min: Int = 0
    var max: Int = 100
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        colorButton(increaseButton)
        colorButton(decreaseButton)
        
        input?.target = self
        input?.action = "inputSetValue:"
    }
    
    func colorButton(button: NSButton?)
    {
        let attributed = NSMutableAttributedString(attributedString: (button?.attributedTitle)!)
        
        colorize(attributed, color: WhiteColor)
        
        button?.attributedTitle = attributed
    }
    
    func move(x: Int, y: Int)
    {
        self.view.setFrameOrigin(NSMakePoint(CGFloat(x), CGFloat(y)))
    }
    
    @IBAction func increase(sender: AnyObject?)
    {
        setValue(getValue() + 1)
    }
    
    @IBAction func decrease(sender: AnyObject?)
    {
        setValue(getValue() - 1)
    }
    
    @IBAction func inputSetValue(sender: AnyObject?)
    {
        setValue(getValue())
    }
    
    func trigger()
    {
        targetObj?.performSelector(actionObj!, withObject: self)
    }
    
    func setupSuffix(suffix: String)
    {
        self.suffix?.stringValue = suffix
        self.resizeToSuffix(suffix)
    }
    
    func resizeToSuffix(suffix: String)
    {
        if suffix == "" {
            view.setFrameSize(NSMakeSize(110, 28))
            
            increaseButton?.frame.origin.x = 110 - 30
            input?.frame.origin.x = 110 - 33 - 30 - 6
        }
    }
    
    func getValue() -> Int
    {
        return Int((input?.intValue)!)
    }
    
    func setValue(value: Int)
    {
        input?.intValue = Int32(clamp(value, self.min, self.max))
        
        trigger()
    }
}
