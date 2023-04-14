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
    
    var cellsRow0: [Cell]!
    var cellsRow1: [Cell]!
    var cellsRow2: [Cell]!
    var cellsRow3: [Cell]!
    var rows: [[Cell]]!
    
    override func setUp() {
        table = Table()
        
        emptyCell1 = Cell(table: table)
        emptyCell2 = Cell(table: table)
        valuedCell2 = Cell(table: table, box: boxedOf2)
        valuedCell2Other = Cell(table: table, box: boxedOf2)
        valuedCell4 = Cell(table: table, box: boxedOf4)
        valuedCell4Other = Cell(table: table, box: boxedOf4)
        valuedCell8 = Cell(table: table, box: boxedOf8)
        valuedCell16 = Cell(table: table, box: boxedOf16)
    }

    func testTable() {
        XCTAssertEqual(CountOfCellsInARowOrColumn, table.rows.count)
        XCTAssertEqual(CountOfCellsInARowOrColumn, table.columns.count)
        XCTAssertEqual(TotalCountOfCells, table.cells.count)
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
    
    func testTableReversedRow() {
        for rowIndex in 0..<CountOfCellsInARowOrColumn {
            let row = table.rows[rowIndex]
            let reversedRow = table.reversedRows[rowIndex]
            XCTAssertEqual(reversedRow, row.reversed())
        }
    }
    
    func testTableReversedColumns() {
        for columnIndex in 0..<CountOfCellsInARowOrColumn {
            let column = table.rows[columnIndex]
            let reversedColumn = table.reversedRows[columnIndex]
            XCTAssertEqual(reversedColumn, column.reversed())
        }
    }
    
    /// Adds some known boxes to the known cells of the table
    private func prepareTableForPushLeadingRows() {
        // Add two values to the first row
        table.rows[0][0].box = boxedOf2
        table.rows[0][3].box = boxedOf2
        
        // Should be pushed to
        cellsRow0 = [emptyCell1, emptyCell1, emptyCell1, valuedCell4]
        
        // Add four values to the second row
        table.rows[1][0].box = boxedOf4
        table.rows[1][1].box = boxedOf4
        table.rows[1][2].box = boxedOf2
        table.rows[1][3].box = boxedOf2
        
        // Should be pushed to
        cellsRow1 = [emptyCell1, emptyCell1, valuedCell8, valuedCell4]
        
        // Add two values to the third row
        table.rows[2][1].box = boxedOf8
        table.rows[2][2].box = boxedOf8
        
        // Should be pushed to
        cellsRow2 = [emptyCell1, emptyCell1, emptyCell1, valuedCell16]

        // Add four values to the fourth row
        table.rows[3][0].box = boxedOf2
        table.rows[3][1].box = boxedOf4
        table.rows[3][2].box = boxedOf4
        table.rows[3][3].box = boxedOf8
        
        // Should be pushed to
        cellsRow3 = [emptyCell1, emptyCell1, valuedCell2, valuedCell16]
        
        // Making expected rows
        rows = [cellsRow0, cellsRow1, cellsRow2, cellsRow3]
    }
    
    func testTablePushLeading() {
        prepareTableForPushLeadingRows()
        table.push(direction: .leading)
        XCTAssertEqual(rows, table.rows)
    }
    
    private func prepareTableForPushTrailingRows() {
        // Add two values to the first row
        table.rows[0][0].box = boxedOf2
        table.rows[0][3].box = boxedOf2
        
        // Should be pushed to
        cellsRow0 = [valuedCell4, emptyCell1, emptyCell1, emptyCell1]
        
        // Add four values to the second row
        table.rows[1][0].box = boxedOf4
        table.rows[1][1].box = boxedOf4
        table.rows[1][2].box = boxedOf2
        table.rows[1][3].box = boxedOf2
        
        // Should be pushed to
        cellsRow1 = [valuedCell4, valuedCell8, emptyCell1, emptyCell1]
        
        // Add two values to the third row
        table.rows[2][1].box = boxedOf8
        table.rows[2][2].box = boxedOf8
        
        // Should be pushed to
        cellsRow2 = [valuedCell16, emptyCell1, emptyCell1, emptyCell1]
        
        // Add four values to the fourth row
        table.rows[3][0].box = boxedOf2
        table.rows[3][1].box = boxedOf4
        table.rows[3][2].box = boxedOf4
        table.rows[3][3].box = boxedOf8
        
        // Should be pushed to
        cellsRow3 = [valuedCell2, valuedCell16, emptyCell1, emptyCell1]
        
        // Making expected rows
        rows = [cellsRow0, cellsRow1, cellsRow2, cellsRow3]
    }

    func testTablePushTrailing() {
        prepareTableForPushTrailingRows()
        table.push(direction: .trailing)
        XCTAssertEqual(rows, table.rows)
    }
}
