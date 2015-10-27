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
        var observer = Observer<Int, Void>()
        var value = 10
        
        observer.add({ (foo: Int) -> Void in
            XCTAssertEqual(foo, value, "Two args arent equals")
        })
        
        observer.invoke(value)
    }
    
    func testObserverWithDict()
    {
        var observer = Observer<Dictionary<String, AnyObject?>, Void>()
        var value: [String: AnyObject?] = [
            "cool": "value"
        ]
        
        observer.add({ (foo: Dictionary<String, AnyObject?>) -> Void in
            XCTAssertEqual(
                "value", foo["cool"] as! String,
                "Given dictionary doesn't have such value"
            )
            
            return
        })
        
        observer.invoke(value)
    }
}
