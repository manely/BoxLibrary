//
//  File.swift
//  
//
//  Created by Mani Hamedani on 4/12/23.
//

import XCTest
@testable import BoxLibrary

final class ArrayCellExtensionTests: XCTestCase {
    let table = Table()
    let boxedOf2 = Box(value: 2)
    let boxedOf4 = Box(value: 4)
    let boxedOf8 = Box(value: 8)
    
    var emptyCell1: Cell!
    var emptyCell2: Cell!
    var valuedCell2: Cell!
    var valuedCell2Other: Cell!
    var valuedCell4: Cell!
    var valuedCell4Other: Cell!
    var valuedCell8: Cell!
    var cellsArray: [Cell]!
    
    override func setUp() {
        emptyCell1 = Cell(table: table)
        emptyCell2 = Cell(table: table)
        valuedCell2 = Cell(table: table, box: boxedOf2)
        valuedCell2Other = Cell(table: table, box: boxedOf2)
        valuedCell4 = Cell(table: table, box: boxedOf4)
        valuedCell4Other = Cell(table: table, box: boxedOf4)
        valuedCell8 = Cell(table: table, box: boxedOf8)
    }
    
    func testPushToArrayOfEmptyValueEmptyValueCell() {
        cellsArray = [emptyCell1, valuedCell2, emptyCell1, valuedCell2Other]
        let pushedArray = cellsArray.push()
        let expectedArray = [emptyCell1, emptyCell1, emptyCell1, valuedCell4]
        XCTAssertEqual(expectedArray, pushedArray)
    }
    
    func testPushToArrayOfValueEmptyValueEmptyCell() {
        cellsArray = [valuedCell4, emptyCell1, valuedCell4Other, emptyCell2]
        let pushedArray = cellsArray.push()
        let expectedArray = [emptyCell1, emptyCell1, emptyCell1, valuedCell8]
        XCTAssertEqual(expectedArray, pushedArray)
    }
    
    func testPushToArrayOfValueValueValueEmptyCell() {
        cellsArray = [valuedCell4, valuedCell2, valuedCell4Other, emptyCell2]
        let pushedArray = cellsArray.push()
        let expectedArray = [emptyCell2, valuedCell4, valuedCell2, valuedCell4Other]
        XCTAssertEqual(expectedArray, pushedArray)
    }
    
    func testPushToArrayOfValueValueValueValueCell() {
        cellsArray = [valuedCell4, valuedCell4Other, valuedCell2, valuedCell2Other]
        let pushedArray = cellsArray.push()
        let expectedArray = [emptyCell1, emptyCell2, valuedCell8, valuedCell2Other] // valuedCell2Other now containes box(value: 4)
        XCTAssertEqual(expectedArray, pushedArray)
    }
    
    func testPushToArrayOfValueValueEmptyEmptyCell() {
        cellsArray = [valuedCell4, valuedCell2, emptyCell1, emptyCell2]
        let pushedArray = cellsArray.push()
        let expectedArray = [emptyCell1, emptyCell2, valuedCell4, valuedCell2]
        XCTAssertEqual(expectedArray, pushedArray)
    }
    
    func testPushToArrayOfEmptyEmptyEmptyValueCell() {
        cellsArray = [emptyCell1, emptyCell2, emptyCell2, valuedCell2]
        let pushedArray = cellsArray.push()
        let expectedArray = [emptyCell1, emptyCell2, emptyCell2, valuedCell2]
        XCTAssertEqual(expectedArray, pushedArray)
    }
    
    func testPushToArrayOfEmptyEmptyValueValueCell() {
        cellsArray = [emptyCell1, emptyCell2, valuedCell2, valuedCell2Other]
        let pushedArray = cellsArray.push()
        let expectedArray = [emptyCell1, emptyCell2, emptyCell2, valuedCell4]
        XCTAssertEqual(expectedArray, pushedArray)
    }
}
