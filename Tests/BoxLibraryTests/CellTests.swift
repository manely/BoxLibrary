//
//  File.swift
//  
//
//  Created by Mani Hamedani on 4/11/23.
//

import XCTest
@testable import BoxLibrary

final class CellTests: XCTestCase {
    let table = Table()
    let boxedOf2 = Box(value: 2)
    let boxedOf4 = Box(value: 4)
    var emptyCell1: Cell!
    var emptyCell2: Cell!
    var valuedCell2: Cell!
    var valuedCell2Other: Cell!
    var valuedCell4: Cell!

    override func setUp() {
        emptyCell1 = Cell(table: table)
        emptyCell2 = Cell(table: table)
        valuedCell2 = Cell(table: table, box: boxedOf2)
        valuedCell2Other = Cell(table: table, box: boxedOf2)
        valuedCell4 = Cell(table: table, box: boxedOf4)
    }
    
    func testPushEmptyCellToEmptyCell() {
        let pushResult = emptyCell1.push(to:  emptyCell2)
        XCTAssertFalse(pushResult)
        XCTAssertNil(emptyCell1.box)
        XCTAssertNil(emptyCell2.box)
    }
    
    func testPushValuedCellToEmptyCell() {
        let pushResult = valuedCell2.push(to:  emptyCell1)
        XCTAssertTrue(pushResult)
        XCTAssertEqual(boxedOf2, emptyCell1.box)
        XCTAssertNil(valuedCell2.box)
    }
    
    func testPushEmptyCellToValuedCell() {
        let pushResult = emptyCell1.push(to:  valuedCell2)
        XCTAssertFalse(pushResult)
        XCTAssertNil(emptyCell1.box)
        XCTAssertEqual(boxedOf2, valuedCell2.box)
    }
    
    func testPushValuedCell2ToValuedCell4() {
        let pushResult = valuedCell2.push(to:  valuedCell4)
        XCTAssertFalse(pushResult)
        XCTAssertEqual(boxedOf2, valuedCell2.box)
        XCTAssertEqual(boxedOf4, valuedCell4.box)
    }
    
    func testPushValuedCell2ToValuedCell2Other() {
        let pushResult = valuedCell2.push(to:  valuedCell2Other)
        XCTAssertTrue(pushResult)
        XCTAssertNil(valuedCell2.box)
        XCTAssertEqual(boxedOf4, valuedCell2Other.box)
    }
}
