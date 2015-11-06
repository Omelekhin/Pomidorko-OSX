//
//  Colors.swift
//  Pomidorko
//
//  Created by Volter on 22.10.15.
//  Copyright (c) 2015 volter9. All rights reserved.
//

import Cocoa

/** Colors */

var RedColor: NSColor = hex(0xed4455)
var LightRedColor: NSColor = hex(0xeb6169)

var BlueColor: NSColor = hex(0x08b1cf)
var LightBlueColor: NSColor = hex (0x68c4db)

var WhiteColor: NSColor = hex(0xffffff)
var LightGreyColor: NSColor = hex(0xf7f7f7)

/** Color functions */

func rgb(red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat = 1.0) -> NSColor
{
    return NSColor(
        red:   red / 255,
        green: green / 255,
        blue:  blue / 255,
        alpha: alpha
    )
}

func hex(hex: Int, alpha: CGFloat = 1.0) -> NSColor
{
    return rgb(
        CGFloat(hex >> 16 & 0xff),
        green: CGFloat(hex >> 8  & 0xff),
        blue:  CGFloat(hex       & 0xff),
        alpha: alpha
    )
}