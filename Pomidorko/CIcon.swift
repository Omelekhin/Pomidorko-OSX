//
//  CIcon.swift
//  Pomidorko
//
//  Created by Volter on 19.12.15.
//  Copyright © 2015 volter9. All rights reserved.
//

import Cocoa

class CIcon: NSObject, Component
{
    var settings: Settings?
    
    init(settings: Settings?)
    {
        self.settings = settings
    }
    
    func activate()
    {
        settings?.observer.add({ (dict: KVDict) -> Void in
            self.toggleDockIcon(self.settings?.get("dock") as! Bool)
        })
        
        toggleDockIcon(self.settings?.get("dock") as! Bool)
    }
    
    func toggleDockIcon(toggle: Bool)
    {
        NSApp.setActivationPolicy(toggle == true
            ? NSApplicationActivationPolicy.Regular
            : NSApplicationActivationPolicy.Accessory)
    }
}
