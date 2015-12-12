//
//  HoverableButton.swift
//  Pomidorko
//
//  Created by Volter on 12.12.15.
//  Copyright © 2015 volter9. All rights reserved.
//

import Cocoa

class HoverableButton: NSButton
{
    var cursor: NSCursor?
    
    override func resetCursorRects()
    {
        if cursor != nil {
            self.addCursorRect(bounds, cursor: cursor!)
        }
        else {
            super.resetCursorRects()
        }
    }
}
