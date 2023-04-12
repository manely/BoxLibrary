//
//  File.swift
//  
//
//  Created by Mani Hamedani on 4/12/23.
//

import Foundation

extension Array where Element == Cell {
    /// Returns the `Table` instance which holds the elements of this instance.
    var table: Table {
        (self.first?.table)!
    }
    
    /// Filters the non-empty `Cell`s out and pushes the cells of the filtered array from the first to the last.
    ///
    /// If the `count` of pushed array is less than the `CountOfColumns`, this methods inserts new empty
    /// `Cell`s to the beginning of the pushed array, so its `count` is equal to `CountOfColumns`.
    ///
    /// - returns   A new array containing the pushed `Cell`s.
    func push() -> [Element] {
        var filtered = self.filter { !$0.isEmpty }
        var originalFilteredCount = 0
        
        repeat {
            originalFilteredCount = filtered.count
            for (index, cell) in filtered.enumerated() {
                guard index + 1 < filtered.count else {
                    break
                }
                let nextCell = filtered[index + 1]
                try? cell.push(to: nextCell)
            }
            
            // filtered needs to get filtered again, since after push there may be empty cells in it.
            filtered = filtered.filter { !$0.isEmpty }
            
        } while (originalFilteredCount > filtered.count)
        
        // filtered needs to get filtered again, since after push th۴۵ere may be empty cells in it.
        filtered = filtered.filter { !$0.isEmpty }

        var cellCountDifference = CountOfCellsInARowOrColumn - filtered.count
        while cellCountDifference > 0 {
            filtered.insert(Cell(table: self.table), at: 0)
            cellCountDifference -= 1
        }
        return filtered
    }
}

extension Array where Element == [Cell] {
    
    /// Pushes each `Element` which is of type `[Cell]`.
    ///
    /// This is a convenience method to make working with `[[Cell]]` instances easier.
    mutating func push() -> Self {
//        var arrayOfCells = [[Cell]]()
//        for cells in self {
//            let temp = cells.push()
//            arrayOfCells.append(temp)
//        }
//        self = arrayOfCells
        for (index, cells) in self.enumerated() {
            self[index] = cells.push()
        }
        return self
    }
}
