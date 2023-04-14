//
//  File.swift
//  
//
//  Created by Mani Hamedani on 4/11/23.
//

import Foundation

enum PushDirection {
    case leading, trailing, top, bottom
}

final class Table {
    
    /// The array which holds the total cells of this instance as a two-dimensional array of `Cell`.
    ///
    /// Each element of this array is a row of `Cell` instances.
    private(set) lazy var rows: [[Cell]] = initRows()
    
    private lazy var row: [Cell] = initSingleRow()
    
    private func initSingleRow() -> [Cell] {
        var result = [Cell]()
        for _ in 0..<CountOfCellsInARowOrColumn {
            result.append(Cell(table: self))
        }
        return result
    }
    
    private func initRows() -> [[Cell]] {
        var result = [[Cell]]()
        for _ in 0..<CountOfCellsInARowOrColumn {
            result.append(initSingleRow())
        }
        return result
    }
    
    /// The total cells in this instance
    var cells: [Cell] {
        // TODO: - can be replaced with
//        Array(rows.joined())
        rows.flatMap { $0 }
    }
    
    private var _columns: [[Cell]]!
    
    /// The array which holds the total cells of this instance as a two-dimensional array of `Cell`.
    ///
    ///  Each element of this array is a column of `Cell` instances.
    var columns: [[Cell]] {
        if _columns == nil {
            _columns = []
            for i in 0..<CountOfCellsInARowOrColumn {
                let col = rows.compactMap { $0[i] }
                _columns.append(col)
            }
        }
        return _columns
    }
    
    private var _reversedRows: [[Cell]]!
    
    var reversedRows: [[Cell]] {
        get {
            // TODO: this algorithm can be replaced by map; also for reversedColumns
            if _reversedRows == nil {
                _reversedRows = []
                for row in rows {
                    _reversedRows.append(row.reversed())
                }
            }
            return _reversedRows
        }
        set {
            self.rows = newValue
            _reversedRows = nil
        }
    }
    
    private var _reversedColumns: [[Cell]]!
    
    var reversedColumns: [[Cell]] {
        if _reversedColumns == nil {
            _reversedColumns = []
            for column in columns {
                _reversedColumns.append(column.reversed())
            }
        }
        return _reversedColumns
    }
    
    func addInitialBoxes() {
        for value: UInt in 1...2 {
            let randomIndex = Int.random(in: 0..<TotalCountOfCells)
            self.cells[randomIndex].box = Box(value: 2 * value)
        }
        
    }
    
    func push(direction: PushDirection) {
        switch direction {
            case .leading:
                self.rows.pushRowsInPlace()
            case .trailing:
                self.rows.pushRowsInPlaceReverse()
            case .top:
                self.rows.pushInPlace()
            case .bottom:
                self.rows.pushInPlaceReverse()
        }
    }
}

// MARK: - Control panel

let CountOfCellsInARowOrColumn = 4
let TotalCountOfCells = 16

let boxOfTwo = Box(value: 2)
let boxOfFour = Box(value: 4)
