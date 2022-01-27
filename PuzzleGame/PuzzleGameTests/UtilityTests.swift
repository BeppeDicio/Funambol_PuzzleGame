//
//  UtilityTests.swift
//  PuzzleGameTests
//
//  Created by Giuseppe Diciolla on 27/01/22.
//

import XCTest
@testable import PuzzleGame

class UtilityTests: XCTestCase {

    func testArrayOfUIImageAreEqual_Different() throws {
        
        let utility = Utility()
        
        let array1 = [UIImage(named: "default")!]
        let array2 = [UIImage(named: "coffee")!]
        
        XCTAssertEqual(utility.arrayOfUIImageAreEqual(firstArray: array1, secondArray: array2), false)
        
    }
    
    func testArrayOfUIImageAreEqual_Equal() throws {
        
        let utility = Utility()
        
        let array1 = [UIImage(named: "coffee")!]
        let array2 = [UIImage(named: "coffee")!]
        
        XCTAssertEqual(utility.arrayOfUIImageAreEqual(firstArray: array1, secondArray: array2), true)
        
    }
    
    func testArrayOfUIImageAreEqual_Equal2() throws {
        
        let utility = Utility()
        
        let array1 = [UIImage(named: "coffee")!, UIImage(named: "default")!, UIImage(named: "default")!]
        let array2 = [UIImage(named: "coffee")!, UIImage(named: "default")!, UIImage(named: "default")!]
        
        XCTAssertEqual(utility.arrayOfUIImageAreEqual(firstArray: array1, secondArray: array2), true)
        
    }
    
    func testArrayOfUIImageAreEqual_Different2() throws {
        
        let utility = Utility()
        
        let array1 = [UIImage(named: "coffee")!, UIImage(named: "default")!, UIImage(named: "default")!]
        let array2 = [UIImage(named: "default")!, UIImage(named: "coffee")!, UIImage(named: "default")!]
        
        XCTAssertEqual(utility.arrayOfUIImageAreEqual(firstArray: array1, secondArray: array2), false)
        
    }

}
