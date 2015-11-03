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
        
        self.view.window?.backgroundColor = BlueColor
        self.view.window?.titlebarAppearsTransparent = true
        
        let existingStyleMask = self.view.window!.styleMask
        
        self.view.window?.styleMask = existingStyleMask | NSFullSizeContentViewWindowMask
        
        control?.backgroundColor = LightBlueColor
        
        skip?.attributedTitle = colorize(
            self.skip?.attributedTitle,
            color: WhiteColor
        )
        
        let goalTitle = NSMutableAttributedString(
            attributedString: (self.goals?.attributedStringValue)!
        )
        
        increase(goalTitle,
            font: NSFont.systemFontOfSize(14),
            offset: 3,
            length: 28
        )
        increase(goalTitle,
            font: NSFont.systemFontOfSize(20),
            offset: 6,
            length: 2
        )
        
        goals?.attributedStringValue = goalTitle
    }
    
    func initComponents()
    {
        let components: Array<Component> = [
            CGoals()
        ]
        
        print(components)
    }
}

