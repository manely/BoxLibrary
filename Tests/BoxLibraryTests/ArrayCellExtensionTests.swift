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
    var cellsArrayOther: [Cell]!
    
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
    
    // MARK: - [Cell].push() tests
    
    func testPushToArrayOfEmptyValue2EmptyValue2Cell() {
        cellsArray = [emptyCell1, valuedCell2, emptyCell1, valuedCell2Other]
        cellsArray.push()
        let expectedArray = [emptyCell1, emptyCell1, emptyCell1, valuedCell4]
        XCTAssertEqual(expectedArray, cellsArray)
    }
    
    func testPushToArrayOfValue4EmptyValue4EmptyCell() {
        cellsArray = [Cell(table: table, box: boxedOf4), Cell(table: table), Cell(table: table, box: boxedOf4), Cell(table: table)]
        cellsArray.push()
        let expectedArray = [emptyCell1, emptyCell1, emptyCell1, valuedCell8]
        XCTAssertEqual(expectedArray, cellsArray)
    }
    
    func testPushToArrayOfValue4Value2Value4EmptyCell() {
        cellsArray = [Cell(table: table, box: boxedOf4), Cell(table: table, box: boxedOf2), Cell(table: table, box: boxedOf4), Cell(table: table)]
        cellsArray.push()
        let expectedArray = [Cell(table: table), Cell(table: table, box: boxedOf4), Cell(table: table, box: boxedOf2), Cell(table: table, box: boxedOf4)]
        XCTAssertEqual(expectedArray, cellsArray)
    }
    
    func testPushToArrayOfValue4Value2EmptyEmptyCell() {
        cellsArray = [Cell(table: table, box: boxedOf4), Cell(table: table, box: boxedOf2), Cell(table: table), Cell(table: table)]
        cellsArray.push()
        let expectedArray = [Cell(table: table), Cell(table: table), Cell(table: table, box: boxedOf4), Cell(table: table, box: boxedOf2)]
        XCTAssertEqual(expectedArray, cellsArray)
    }
    
    func testPushToArrayOfEmptyEmptyEmptyValue2Cell() {
        cellsArray = [Cell(table: table), Cell(table: table), Cell(table: table), Cell(table: table, box: boxedOf2)]
        cellsArray.push()
        let expectedArray = [emptyCell1, emptyCell2, emptyCell2, valuedCell2]
        XCTAssertEqual(expectedArray, cellsArray)
    }
    
    func testPushToArrayOfEmptyEmptyValue2Value2Cell() {
        cellsArray = [Cell(table: table), Cell(table: table), Cell(table: table, box: boxedOf2), Cell(table: table, box: boxedOf2)]
        cellsArray.push()
        let expectedArray = [emptyCell1, emptyCell2, emptyCell2, valuedCell4]
        XCTAssertEqual(expectedArray, cellsArray)
    }

    // FIXME: - problem in push algorithm; equal cells must mix first
    // currently cells are pushed adjacently; rather equal ones must first get mixed
    // This case is passed by chance!
    func testPushToArrayOfValue4Value4Value2Value2Cell() {
        cellsArray = [Cell(table: table, box: boxedOf4), Cell(table: table, box: boxedOf4), Cell(table: table, box: boxedOf2), Cell(table: table, box: boxedOf2)]
        cellsArray.push()
        let expectedArray = [emptyCell1, emptyCell2, valuedCell8, Cell(table: table, box: boxedOf4)]
        XCTAssertEqual(expectedArray, cellsArray)
    }

    func testPushToArrayOfValue2Value2Value4Value4Cell() {
        cellsArray = [Cell(table: table, box: boxedOf2), Cell(table: table, box: boxedOf2), Cell(table: table, box: boxedOf4), Cell(table: table, box: boxedOf4)]
        cellsArray.push()
        let expectedArray = [emptyCell1, emptyCell2, valuedCell8, Cell(table: table, box: boxedOf4)]
        XCTAssertEqual(expectedArray, cellsArray)
    }

    func testPushToArrayOfValue8Value4Value4Value2Cell() {
        cellsArray = [Cell(table: table, box: boxedOf8), Cell(table: table, box: boxedOf4), Cell(table: table, box: boxedOf4), Cell(table: table, box: boxedOf2)]
        cellsArray.push()
        let expectedArray = [emptyCell1, emptyCell2, valuedCell16, valuedCell2]
        XCTAssertEqual(expectedArray, cellsArray)
    }

    func testPushToArrayOfValue8Value2Value4Value4Cell() {
        cellsArray = [Cell(table: table, box: boxedOf8), Cell(table: table, box: boxedOf2), Cell(table: table, box: boxedOf4), Cell(table: table, box: boxedOf4)]
        cellsArray.push()
        let expectedArray = [emptyCell1, Cell(table: table, box: boxedOf8), Cell(table: table, box: boxedOf2), Cell(table: table, box: boxedOf8)]
        XCTAssertEqual(expectedArray, cellsArray)
    }

    func testPushToArrayOfValue4Value2Value2Value2Cell() {
        let localValuedCell2 = Cell(table: table, box: boxedOf2)
        cellsArray = [valuedCell4, valuedCell2, valuedCell2Other, localValuedCell2]
        cellsArray.push()
        XCTAssertEqual(boxedOf8, valuedCell2Other.box)
        let expectedArray = [emptyCell1, emptyCell2, valuedCell8, localValuedCell2]
        XCTAssertEqual(expectedArray, cellsArray)
    }

    // MARK: - [Cell].pushReverse() tests
    
    func testPushReverseToArrayOfEmptyValue2EmptyValue2Cell() {
        cellsArray = [emptyCell1, valuedCell2, emptyCell2, valuedCell2Other]
        cellsArray.pushReverse()
        let expectedArray = [Cell(table: table, box: boxedOf4), Cell(table: table), Cell(table: table), Cell(table: table)]
        XCTAssertEqual(expectedArray, cellsArray)
    }
    
    func testPushReverseToArrayOfValue4EmptyValue4EmptyCell() {
        cellsArray = [valuedCell4, emptyCell1, valuedCell4Other, emptyCell2]
        cellsArray.pushReverse()
        let expectedArray = [valuedCell8, Cell(table: table), Cell(table: table), Cell(table: table)]
        XCTAssertEqual(expectedArray, cellsArray)
    }
    
    func testPushReverseToArrayOfValue4Value2Value4EmptyCell() {
        cellsArray = [valuedCell4, valuedCell2, valuedCell4Other, emptyCell2]
        cellsArray.pushReverse()
        let expectedArray = [Cell(table: table, box: boxedOf4), Cell(table: table, box: boxedOf2), Cell(table: table, box: boxedOf4), Cell(table: table)]
        XCTAssertEqual(expectedArray, cellsArray)
    }
    
    func testPushReverseToArrayOfEmptyEmptyValue4Value2Cell() {
        cellsArray = [emptyCell1, emptyCell2, valuedCell4, valuedCell2]
        cellsArray.pushReverse()
        let expectedArray = [Cell(table: table, box: boxedOf4), Cell(table: table, box: boxedOf2), Cell(table: table), Cell(table: table)]
        XCTAssertEqual(expectedArray, cellsArray)
    }
    
    func testPushReverseToArrayOfEmptyEmptyEmptyValue2Cell() {
        cellsArray = [Cell(table: table), Cell(table: table), Cell(table: table), Cell(table: table, box: boxedOf2)]
        cellsArray.pushReverse()
        let expectedArray = [Cell(table: table, box: boxedOf2), Cell(table: table), Cell(table: table), Cell(table: table)]
        XCTAssertEqual(expectedArray, cellsArray)
    }
    
    func testPushReverseToArrayOfEmptyEmptyValue2Value2Cell() {
        cellsArray = [emptyCell1, emptyCell2, valuedCell2, valuedCell2Other]
        cellsArray.pushReverse()
        let expectedArray = [Cell(table: table, box: boxedOf4), Cell(table: table), Cell(table: table), Cell(table: table)]
        XCTAssertEqual(expectedArray, cellsArray)
    }
    
    // FIXME: - problem in push! equal cells must get mixed first
    // this case must produce: 8, 4, 0, 0, but yields 4, 8, 0, 0
    // also, only one or two mixes must be done in each time
    func testPushReverseToArrayOfValue4Value4Value2Value2Cell() {
        cellsArray = [valuedCell4, valuedCell4Other, valuedCell2, valuedCell2Other]
        cellsArray.pushReverse()
        let expectedArray = [Cell(table: table, box: boxedOf4), Cell(table: table, box: boxedOf8), Cell(table: table), Cell(table: table)]
        XCTAssertEqual(expectedArray, cellsArray)
    }
    
    func testPushReverseToArrayOfValue8Value4Value4Value2Cell() {
        cellsArray = [valuedCell8, valuedCell4, valuedCell4Other, valuedCell2]
        cellsArray.pushReverse()
        let expectedArray = [valuedCell16, Cell(table: table, box: boxedOf2), Cell(table: table), Cell(table: table)]
        XCTAssertEqual(expectedArray, cellsArray)
    }
    
    func testPushReverseToArrayOfValue8Value2Value4Value4Cell() {
        cellsArray = [valuedCell8, valuedCell2, valuedCell4, valuedCell4Other]
        cellsArray.pushReverse()
        let expectedArray = [Cell(table: table, box: boxedOf8), Cell(table: table, box: boxedOf2), Cell(table: table, box: boxedOf8), emptyCell1]
        XCTAssertEqual(expectedArray, cellsArray)
    }
    
    func testPushReverseToArrayOfValue4Value2Value2Value2Cell() {
        let localValuedCell2 = Cell(table: table, box: boxedOf2)
        cellsArray = [valuedCell4, valuedCell2, valuedCell2Other, localValuedCell2]
        cellsArray.pushReverse()
        let expectedArray = [Cell(table: table, box: boxedOf4), Cell(table: table, box: boxedOf2), Cell(table: table, box: boxedOf4), emptyCell1]
        XCTAssertEqual(expectedArray, cellsArray)
    }

    // MARK: - [Cell].push(to: [Cell]) tests
    
    func testPushArrayOf2408To0428() {
        cellsArray = [Cell(table: table, box: boxedOf2), Cell(table: table, box: boxedOf4), Cell(table: table), Cell(table: table, box: boxedOf8)]
        cellsArrayOther = [Cell(table: table), Cell(table: table, box: boxedOf4), Cell(table: table, box: boxedOf2), Cell(table: table, box: boxedOf8)]
        let pushResult = cellsArray.push(to: cellsArrayOther)
        let expectedArray = [Cell(table: table, box: boxedOf2), Cell(table: table, box: boxedOf8), Cell(table: table, box: boxedOf2), Cell(table: table, box: boxedOf16)]
        XCTAssertEqual(expectedArray, cellsArrayOther)
        XCTAssertEqual([1, 1, 0, 1], pushResult)
    }
    
    func testPushArrayOf0000To2222() {
        cellsArray = [emptyCell1, emptyCell1, emptyCell1, emptyCell1]
        cellsArrayOther = [valuedCell2, valuedCell2, valuedCell2Other, valuedCell2Other]
        let pushResult = cellsArray.push(to: cellsArrayOther)
        let expectedArray = [Cell(table: table, box: boxedOf2), Cell(table: table, box: boxedOf2), Cell(table: table, box: boxedOf2), Cell(table: table, box: boxedOf2)]
        XCTAssertEqual(expectedArray, cellsArrayOther)
        XCTAssertEqual([0, 0, 0, 0], pushResult)
    }
    
    func testPushArrayOf2222To0000() {
        cellsArray = [Cell(table: table, box: boxedOf2), Cell(table: table, box: boxedOf2), Cell(table: table, box: boxedOf2), Cell(table: table, box: boxedOf2)]
        cellsArrayOther = [Cell(table: table), Cell(table: table), Cell(table: table), Cell(table: table)]
        let pushResult = cellsArray.push(to: cellsArrayOther)
        let expectedArray = [Cell(table: table, box: boxedOf2), Cell(table: table, box: boxedOf2), Cell(table: table, box: boxedOf2), Cell(table: table, box: boxedOf2)]
        XCTAssertEqual(expectedArray, cellsArrayOther)
        XCTAssertEqual([1, 1, 1, 1], pushResult)
    }

    func testPushArrayOf2222To2222() {
        cellsArray = [Cell(table: table, box: boxedOf2), Cell(table: table, box: boxedOf2), Cell(table: table, box: boxedOf2), Cell(table: table, box: boxedOf2)]
        cellsArrayOther = [Cell(table: table, box: boxedOf2), Cell(table: table, box: boxedOf2), Cell(table: table, box: boxedOf2), Cell(table: table, box: boxedOf2)]
        let pushResult = cellsArray.push(to: cellsArrayOther)
        let expectedArray = [Cell(table: table, box: boxedOf4), Cell(table: table, box: boxedOf4), Cell(table: table, box: boxedOf4), Cell(table: table, box: boxedOf4)]
        XCTAssertEqual(expectedArray, cellsArrayOther)
        XCTAssertEqual([1, 1, 1, 1], pushResult)
    }

    func testPushArrayOf2222To2428() {
        cellsArray = [Cell(table: table, box: boxedOf2), Cell(table: table, box: boxedOf2), Cell(table: table, box: boxedOf2), Cell(table: table, box: boxedOf2)]
        cellsArrayOther = [Cell(table: table, box: boxedOf2), Cell(table: table, box: boxedOf4), Cell(table: table, box: boxedOf2), Cell(table: table, box: boxedOf8)]
        let pushResult = cellsArray.push(to: cellsArrayOther)
        let expectedArray = [Cell(table: table, box: boxedOf4), Cell(table: table, box: boxedOf4), Cell(table: table, box: boxedOf4), Cell(table: table, box: boxedOf8)]
        XCTAssertEqual(expectedArray, cellsArrayOther)
        XCTAssertEqual([1, 0, 1, 0], pushResult)
    }
    
    // MARK: - [[Cell]] tests
    
    func testReverseRowsInPlace() {
        cellsArray = [valuedCell8, valuedCell2, valuedCell4, emptyCell1]
        let localCellsArray = [emptyCell1, valuedCell2, emptyCell2, valuedCell8].map { $0! }
        var array = [cellsArray!, localCellsArray]
        array.reverseRowsInPlace()
        
        let expectedArray = [Array(cellsArray.reversed()), localCellsArray.reversed()]
        XCTAssertEqual(expectedArray, array)
    }
}
