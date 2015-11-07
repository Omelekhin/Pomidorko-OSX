//
//  EventEmitterTest.swift
//  Pomidorko
//
//  Created by Volter on 04.11.15.
//  Copyright © 2015 volter9. All rights reserved.
//

import XCTest

class EventEmitterTest: XCTestCase
{
    func testEmitter()
    {
        let emitter = EventEmitter<Int>()
        let value: Int = 10
        
        emitter.add("shit", closure: { (a: Int) -> Void in
            XCTAssertEqual(a, value, "Given value doesn't match")
        })
        
        emitter.emit("shit", arg: value)
    }
}