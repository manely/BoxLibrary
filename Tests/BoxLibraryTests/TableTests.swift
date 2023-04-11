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
    
    /// Assumes that table initialization process makes two box instances, one with value 2, and other with value 4,
    /// which are placed into two randomly selected cells.
    func testTableInitialBoxesInitialization() {
        table.addInitialBoxes()
        
        var countOfBoxOfTwo = 0
        var countOfBoxOfFour = 0
        
        for row in table.rows {
            for cell in row {
                if cell.box == boxOfTwo {
                    countOfBoxOfTwo += 1
                }
                if cell.box == boxOfFour {
                    countOfBoxOfFour += 1
                }
            }
        }
        
        XCTAssertEqual(1, countOfBoxOfTwo)
        XCTAssertEqual(1, countOfBoxOfFour)
    }
}
