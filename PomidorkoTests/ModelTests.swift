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
        let model: Model = Model(data: [
            "cool": "foo"
        ])
        
        let key = "cool"
        let value = "abc"
        
        model.observer.add({ (dict: KVDict) -> Void in
            XCTAssertEqual(dict[key] as? String, value, "Tots not equals")
        })
        
        model.set(key, value: value)
    }
}