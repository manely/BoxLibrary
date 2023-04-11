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
}
