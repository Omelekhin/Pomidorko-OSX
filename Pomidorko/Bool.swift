//
//  Bool.swift
//  Pomidorko
//
//  Created by Volter on 06.11.15.
//  Copyright © 2015 volter9. All rights reserved.
//

import Foundation

extension Bool
{
    func toInt() -> Int
    {
        return self == true ? 1 : 0
    }
}