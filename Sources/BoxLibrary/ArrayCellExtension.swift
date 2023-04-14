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
    
    /// Pushes the cells of this instance, starting fom pushing the first element to the second, then the second to the
    /// third, up until the last element.
    ///
    /// The process is repeated again if the count of empty cells at the beginning of each phase is less than the count of
    /// empty cells at the end of the phase; that is the result of pushing at least two adjacent cells yields a move (a non-empty
    /// cell pushes its contents to its next empty cell) or mix (pushing two adjacent cells with equal contents, which yields
    /// an empty cell followed by a cell containing the sum of those equal contents).
    ///
    /// All the changes are taken in-place.
    ///
    /// - returns   `self`
    func push() -> [Element] {
        var filtered = self.filter { !$0.isEmpty }
        var countOfEmptyCells = 0
        
        repeat {
            countOfEmptyCells = filtered.count
            for (index, cell) in self.enumerated() {
                guard index + 1 < self.count else {
                    break
                }
                let nextCell = self[index + 1]
                try? cell.push(to: nextCell)
            }
            
            // filtered needs to get filtered again, since after push there may be empty cells in it.
            filtered = filtered.filter { !$0.isEmpty }
            
        } while (countOfEmptyCells > filtered.count)
        
        return self
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
