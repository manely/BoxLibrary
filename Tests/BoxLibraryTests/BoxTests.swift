//
//  File.swift
//  
//
//  Created by Mani Hamedani on 4/11/23.
//

import XCTest
@testable import BoxLibrary

final class BoxTests: XCTestCase {
    func testBox() {
        let b = Box(value: 2)
        XCTAssertEqual(2, b.value)
    }
    
    func testBoxMix() {
        let b1 = Box(value: 2)
        let b2 = Box(value: 2)
        let mixed = b1.mix(with: b2)
        XCTAssertEqual(Box(value: 4), mixed)
    }
    
    func testBoxMixFail() {
        let b1 = Box(value: 2)
        let b2 = Box(value: 4)
        let mixed = b1.mix(with: b2)
        XCTAssertNil(mixed)
    }
}
