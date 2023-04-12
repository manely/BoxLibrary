//
//  File.swift
//  
//
//  Created by Mani Hamedani on 4/11/23.
//

import Foundation

final class Table {
    
    /// The array which holds the total cells of this instance as a two-dimensional array of `Cell`.
    ///
    /// Each element of this array is a row of `Cell` instances.
    private(set) lazy var rows: [[Cell]] = initRows()
    
    private lazy var row: [Cell] = initSingleRow()
    
    private func initSingleRow() -> [Cell] {
        var result = [Cell]()
        for _ in 0..<CountOfColumns {
            result.append(Cell(table: self))
        }
        return result
    }
    
    private func initRows() -> [[Cell]] {
        var result = [[Cell]]()
        for _ in 0..<CountOfRows {
            result.append(initSingleRow())
        }
        return result
    }
    
    /// The total cells in this instance
    var cells: [Cell] {
        rows.flatMap { $0 }
    }
    
    private var _columns: [[Cell]]!
    
    /// The array which holds the total cells of this instance as a two-dimensional array of `Cell`.
    ///
    ///  Each element of this array is a column of `Cell` instances.
    var columns: [[Cell]] {
        guard _columns == nil else {
            return _columns
        }
        _columns = []
        for i in 0..<CountOfColumns {
            let col = rows.compactMap { $0[i] }
            _columns.append(col)
        }
        return _columns
    }
    
    func addInitialBoxes() {
        for value: UInt in 1...2 {
            let randomIndex = Int.random(in: 0..<CountOfCells)
            self.cells[randomIndex].box = Box(value: 2 * value)
        }
        
    }
}

// MARK: - Control panel

let CountOfRows = 4
let CountOfColumns = 4
let CountOfCells = 16

let boxOfTwo = Box(value: 2)
let boxOfFour = Box(value: 4)
