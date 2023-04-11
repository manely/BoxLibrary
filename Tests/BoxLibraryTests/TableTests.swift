//
//  File.swift
//  
//
//  Created by Mani Hamedani on 4/11/23.
//

import XCTest
@testable import BoxLibrary

let countOfColumnsInATable = 4
let countOfRowsInATable = 4
let countOfTotalCells = 16

final class TableTests: XCTestCase {
    func testTable() {
        let t = Table()
        XCTAssertEqual(countOfColumnsInATable, t.rows.count)
        XCTAssertEqual(countOfRowsInATable, t.columns.count)
        XCTAssertEqual(countOfTotalCells, t.cells.count)
    }
    
    func testTableCellsOfRowsRelationship() {
        let t = Table()
        for row in t.rows {
            for cell in row {
                XCTAssertIdentical(t, cell.table)
            }
        }
    }
    
    func testTableCellsOfColumnsRelationship() {
        let t = Table()
        for col in t.columns {
            for cell in col {
                XCTAssertIdentical(t, cell.table)
            }
        }
    }
    
    func testTableCellsInitiallyHaveNoBox() {
        let t = Table()
        for row in t.rows {
            for cell in row {
                XCTAssertNil(cell.box)
            }
        }
    }
}
