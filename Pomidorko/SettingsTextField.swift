//
//  SettingsTextField.swift
//  Pomidorko
//
//  Created by Volter on 21.12.15.
//  Copyright © 2015 volter9. All rights reserved.
//

import Cocoa

class SettingsTextField: NSTextField
{
    override func keyUp(theEvent: NSEvent)
    {
        super.keyUp(theEvent)
        
        target?.performSelector(action, withObject: self)
    }
}
