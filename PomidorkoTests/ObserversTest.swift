//
//  ObserverTest.swift
//  Pomidorko
//
//  Created by Volter on 27.10.15.
//  Copyright (c) 2015 volter9. All rights reserved.
//

import Cocoa
import XCTest

class ObserverTest: XCTestCase
{
    func testObserver()
    {
        let observer = Observer<Int, Void>()
        let value = 10
        
        observer.add({ (foo: Int) -> Void in
            XCTAssertEqual(foo, value, "Two args arent equals")
        })
        
        observer.invoke(value)
    }
    
    func testObserverWithDict()
    {
        let observer = Observer<KVDict, Void>()
        let value: KVDict = ["cool": "value"]
        
        observer.add({ (foo: KVDict) -> Void in
            XCTAssertEqual(
                "value", foo["cool"] as? String,
                "Given dictionary doesn't have such value"
            )
        })
        
        observer.invoke(value)
    }
}