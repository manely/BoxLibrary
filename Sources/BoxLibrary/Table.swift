//
//  File.swift
//  
//
//  Created by Mani Hamedani on 4/11/23.
//

import Foundation

@frozen public enum PushDirection {
    case leading, trailing, top, bottom
}

/// Defines a table of `Cell` objects.
///
/// This is the root class of the game engine; together with `Cell` and `Box`, it implements the
/// whole logic of the game.
public final class Table {
    
    // TODO: maybe better to make this public to make accessing rows easier, otherwise we have to use cells only.
    
    /// The array which holds the total cells of this instance as a two-dimensional array of `Cell`.
    ///
    /// Each element of this array is a row of `Cell` instances.
    public private(set) lazy var rows: [[Cell]] = initRows()
    
    private lazy var row: [Cell] = initSingleRow()
    
    // TODO: - Maybe better to add a subscript to this class.
    
    public init() {
        
    }
    
    /// Called in the `initRows()` method to initialize a single row.
    private func initSingleRow() -> [Cell] {
        var result = [Cell]()
        for _ in 0..<CountOfCellsInARowOrColumn {
            result.append(Cell(table: self))
        }
        return result
    }
    
    /// Called to initialize the `rows` property.
    private func initRows() -> [[Cell]] {
        var result = [[Cell]]()
        for _ in 0..<CountOfCellsInARowOrColumn {
            result.append(initSingleRow())
        }
        return result
    }
    
    /// The total cells in this instance
    public var cells: [Cell] {
        Array(rows.joined())
//        rows.flatMap { $0 }
    }
    
    private var _columns: [[Cell]]!
    
    /// The array which holds the total cells of this instance as a two-dimensional array of `Cell`.
    ///
    ///  Each element of this array is a column of `Cell` instances.
    public var columns: [[Cell]] {
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
    
    /// Currently only used in the unit tests and not used in the program logic.
    public var reversedRows: [[Cell]] {
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
    
    /// Currently only used in the unit tests and not used in the program logic.
    public var reversedColumns: [[Cell]] {
        if _reversedColumns == nil {
            _reversedColumns = []
            for column in columns {
                _reversedColumns.append(column.reversed())
            }
        }
        return _reversedColumns
    }
    
    /// Adds two `Box` objects with value of 2 and 4 to the table.
    ///
    /// Called to make the table ready for the game.
    public func addInitialBoxes() {
        for value: UInt in 1...2 {
            let randomIndex = Int.random(in: 0..<TotalCountOfCells)
            self.cells[randomIndex].box = Box(value: 2 * value)
        }
        
    }
    
    /// Pushes the cells in the table according to the game rule, based on the specified direction.
    public func push(direction: PushDirection) {
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
    
    /// Adds a `Box` object with the value of 2 or 4 to the empty cells of the table.
    ///
    /// Called after doing a push on the table.
    public func insertRandomBox() {
        self.emptyCells[self.randomEmptyCellIndex].box = boxOfTwo
    }
    
    /// Returns the cells where their `isEmpty` property is `true`.
    ///
    /// Used in the implementation of `insertRandomBox()` method.
    var emptyCells: [Cell] {
        self.cells.filter { $0.isEmpty }
    }
    
    /// Returns a random integer between zero and `emptyCells.count`.
    var randomEmptyCellIndex: Int {
        Int.random(in: 0..<self.emptyCells.count)
    }
}

// MARK: - Control panel

let CountOfCellsInARowOrColumn = 4
let TotalCountOfCells = 16

let boxOfTwo = Box(value: 2)
let boxOfFour = Box(value: 4)
