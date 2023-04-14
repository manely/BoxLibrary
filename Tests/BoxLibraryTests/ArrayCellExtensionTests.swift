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
    let boxedOf16 = Box(value: 16)
    
    var emptyCell1: Cell!
    var emptyCell2: Cell!
    var valuedCell2: Cell!
    var valuedCell2Other: Cell!
    var valuedCell4: Cell!
    var valuedCell4Other: Cell!
    var valuedCell8: Cell!
    var valuedCell16: Cell!
    
    var cellsArray: [Cell]!
    
    override func setUp() {
        emptyCell1 = Cell(table: table)
        emptyCell2 = Cell(table: table)
        valuedCell2 = Cell(table: table, box: boxedOf2)
        valuedCell2Other = Cell(table: table, box: boxedOf2)
        valuedCell4 = Cell(table: table, box: boxedOf4)
        valuedCell4Other = Cell(table: table, box: boxedOf4)
        valuedCell8 = Cell(table: table, box: boxedOf8)
        valuedCell16 = Cell(table: table, box: boxedOf16)
    }
    
    func testArrayTable() {
        for row in table.rows {
            XCTAssertIdentical(row.table, table)
        }
        for column in table.columns {
            XCTAssertIdentical(column.table, table)
        }
        XCTAssertIdentical(table.cells.table, table)
    }
    
    func testPushToArrayOfEmptyValue2EmptyValue2Cell() {
        cellsArray = [emptyCell1, valuedCell2, emptyCell1, valuedCell2Other]
        let pushedArray = cellsArray.push()
        let expectedArray = [emptyCell1, emptyCell1, emptyCell1, valuedCell4]
        XCTAssertEqual(expectedArray, pushedArray)
    }
    
    func testPushToArrayOfValue4EmptyValue4EmptyCell() {
        cellsArray = [valuedCell4, emptyCell1, valuedCell4Other, emptyCell2]
        let pushedArray = cellsArray.push()
        let expectedArray = [emptyCell1, emptyCell1, emptyCell1, valuedCell8]
        XCTAssertEqual(expectedArray, pushedArray)
    }
    
    func testPushToArrayOfValue4Value2Value4EmptyCell() {
        cellsArray = [valuedCell4, valuedCell2, valuedCell4Other, emptyCell2]
        let pushedArray = cellsArray.push()
        let expectedArray = [Cell(table: table), Cell(table: table, box: boxedOf4), Cell(table: table, box: boxedOf2), Cell(table: table, box: boxedOf4)]
        XCTAssertEqual(expectedArray, pushedArray)
    }
    
    func testPushToArrayOfValue4Value2EmptyEmptyCell() {
        cellsArray = [valuedCell4, valuedCell2, emptyCell1, emptyCell2]
        let pushedArray = cellsArray.push()
        let expectedArray = [Cell(table: table), Cell(table: table), Cell(table: table, box: boxedOf4), Cell(table: table, box: boxedOf2)]
        XCTAssertEqual(expectedArray, pushedArray)
    }
    
    func testPushToArrayOfEmptyEmptyEmptyValue2Cell() {
        cellsArray = [emptyCell1, emptyCell2, emptyCell2, valuedCell2]
        let pushedArray = cellsArray.push()
        let expectedArray = [emptyCell1, emptyCell2, emptyCell2, valuedCell2]
        XCTAssertEqual(expectedArray, pushedArray)
    }
    
    func testPushToArrayOfEmptyEmptyValue2Value2Cell() {
        cellsArray = [emptyCell1, emptyCell2, valuedCell2, valuedCell2Other]
        let pushedArray = cellsArray.push()
        let expectedArray = [emptyCell1, emptyCell2, emptyCell2, valuedCell4]
        XCTAssertEqual(expectedArray, pushedArray)
    }

    func testPushToArrayOfValue4Value4Value2Value2Cell() {
        cellsArray = [valuedCell4, valuedCell4Other, valuedCell2, valuedCell2Other]
        let pushedArray = cellsArray.push()
        XCTAssertEqual(boxedOf8, valuedCell2.box)
        XCTAssertEqual(boxedOf4, valuedCell2Other.box)
        let expectedArray = [emptyCell1, emptyCell2, valuedCell8, valuedCell2Other]
        XCTAssertEqual(expectedArray, pushedArray)
    }

    func testPushToArrayOfValue8Value4Value4Value2Cell() {
        cellsArray = [valuedCell8, valuedCell4, valuedCell4Other, valuedCell2]
        let pushedArray = cellsArray.push()
        XCTAssertEqual(boxedOf16, valuedCell4Other.box)
        let expectedArray = [emptyCell1, emptyCell2, valuedCell16, valuedCell2]
        XCTAssertEqual(expectedArray, pushedArray)
    }

    func testPushToArrayOfValue8Value2Value4Value4Cell() {
        cellsArray = [valuedCell8, valuedCell2, valuedCell4, valuedCell4Other]
        let pushedArray = cellsArray.push()
        XCTAssertEqual(nil, valuedCell8.box)
        XCTAssertEqual(boxedOf8, valuedCell2.box)
        XCTAssertEqual(boxedOf2, valuedCell4.box)
        XCTAssertEqual(boxedOf8, valuedCell4Other.box)
        let expectedArray = [emptyCell1, Cell(table: table, box: boxedOf8), Cell(table: table, box: boxedOf2), Cell(table: table, box: boxedOf8)]
        XCTAssertEqual(expectedArray, pushedArray)
    }

    func testPushToArrayOfValue4Value2Value2Value2Cell() {
        let localValuedCell2 = Cell(table: table, box: boxedOf2)
        cellsArray = [valuedCell4, valuedCell2, valuedCell2Other, localValuedCell2]
        let pushedArray = cellsArray.push()
        XCTAssertEqual(boxedOf8, valuedCell2Other.box)
        let expectedArray = [emptyCell1, emptyCell2, valuedCell8, localValuedCell2]
        XCTAssertEqual(expectedArray, pushedArray)
    }

}
