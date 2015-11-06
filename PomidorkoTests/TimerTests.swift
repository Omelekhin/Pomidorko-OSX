//
//  TimerTests.swift
//  Pomidorko
//
//  Created by Volter on 05.11.15.
//  Copyright © 2015 volter9. All rights reserved.
//

import XCTest

class TimerTests: XCTestCase
{
    func testExample()
    {
        let timer = Timer()
        let expectation = expectationWithDescription("test timer")
        
        var time = 0.0
        
        timer.duration = 5
        
        timer.emitter.add("start", closure: { (t: Double) -> Void in
            XCTAssertTrue(true)
            
            return
        })
        
        timer.emitter.add("tick", closure: { (t: Double) -> Void in
            time += 1
            
            return
        })
        
        timer.emitter.add("stop", closure: { (t: Double) -> Void in
            XCTAssertTrue(
                time >= 115,
                "There wasn't more than 120 ticks, got only \(time)"
            )
            
            expectation.fulfill()
            
            return
        })
        
        timer.start()
        
        waitForExpectationsWithTimeout(6.0, handler: nil)
    }
}
