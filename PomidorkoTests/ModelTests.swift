//
//  ModelTests.swift
//  Pomidorko
//
//  Created by Volter on 27.10.15.
//  Copyright (c) 2015 volter9. All rights reserved.
//

import Cocoa
import XCTest

class ModelTests: XCTestCase
{
    func testModel()
    {
        var model: Model = Model(data: [
            "cool": "foo"
        ])
        
        var key = "cool"
        var value = "abc"
        
        model.observers.add({ (dict: [String: AnyObject?]) -> Void in
            XCTAssertEqual(dict[key] as! String, value, "Tots not equals")
            
            return
        })
        
        model.set(key, value: value)
    }
}
