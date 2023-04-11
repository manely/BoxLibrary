//
//  File.swift
//  
//
//  Created by Mani Hamedani on 4/11/23.
//

import XCTest
@testable import BoxLibrary

final class TableTests: XCTestCase {
    var table: Table!
    
    override func setUp() {
        table = Table()
    }
    
    func testTable() {
        XCTAssertEqual(CountOfRows, table.rows.count)
        XCTAssertEqual(CountOfColumns, table.columns.count)
        XCTAssertEqual(CountOfCells, table.cells.count)
    }
    
    func testTableCellsOfRowsRelationship() {
        for row in table.rows {
            for cell in row {
                XCTAssertIdentical(table, cell.table)
            }
        }
    }
    
    func testTableCellsOfColumnsRelationship() {
        for col in table.columns {
            for cell in col {
                XCTAssertIdentical(table, cell.table)
            }
        }
    }
    
    func testTableCellsInitiallyHaveNoBox() {
        for row in table.rows {
            for cell in row {
                XCTAssertNil(cell.box)
            }
        }
    }
}
