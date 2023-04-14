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
    /// third, and continue until the last element.
    ///
    /// The process is repeated again if there is at least one move, or move and mix in each phase. This can be determined
    /// by checking the return value of `Cell.push(to:)` method, which is `true` if the pushing process yields a move or
    /// move and mix.
    ///
    /// The meaning of move is that a non-empty cell pushes its contents to its next empty cell; the non-empty cells becomes empty. A
    /// move and mix is happened when a non-empty cell is pushed to a its adjacent non-empty cell, where their contents are equal. In this case,
    /// the first cell becomes empty and the next one holds the sum of those equal contents.
    ///
    /// All the changes are taken in-place. In cases where you are working with a `[[Cell]]`, you may need to set the return value of this method
    /// to its counterpart in the containing array, to make the changes in the whole array in-place.
    ///
    /// - returns   `self`
    func push() -> [Element] {
        var countOfMoveOrMix = 0
        
        repeat {
            countOfMoveOrMix = 0
            for (index, cell) in self.enumerated() {
                guard index + 1 < self.count else {
                    break
                }
                let nextCell = self[index + 1]
                let resultOfPush = try? cell.push(to: nextCell)
                if let resultOfPush, resultOfPush {
                    countOfMoveOrMix = resultOfPush ? countOfMoveOrMix + 1 : countOfMoveOrMix
                }
            }
        } while (countOfMoveOrMix > 0)
        
        return self
    }
    
    /// Pushes the cells of this instance, starting fom pushing the last element to the second from the last, then the second to the
    /// third from the last, and continue until the first element.
    ///
    /// The process is repeated again if there is at least one move, or move and mix in each phase. This can be determined
    /// by checking the return value of `Cell.push(to:)` method, which is `true` if the pushing process yields a move or
    /// move and mix.
    ///
    /// The meaning of move is that a non-empty cell pushes its contents to its next empty cell; the non-empty cells becomes empty. A
    /// move and mix is happened when a non-empty cell is pushed to a its adjacent non-empty cell, where their contents are equal. In this case,
    /// the first cell becomes empty and the next one holds the sum of those equal contents.
    ///
    /// All the changes are taken in-place. In cases where you are working with a `[[Cell]]`, you may need to set the return value of this method
    /// to its counterpart in the containing array, to make the changes in the whole array in-place.
    ///
    /// - returns   `self`
    func pushReverse() -> [Element] {
        var countOfMoveOrMix = 0
        
        repeat {
            countOfMoveOrMix = 0
            var index = self.count - 1
            for cell in self.reversed() {
                guard index > 0 else {
                    break
                }
                let nextCell = self[index - 1]
                let resultOfPush = try? cell.push(to: nextCell)
                if let resultOfPush, resultOfPush {
                    countOfMoveOrMix = resultOfPush ? countOfMoveOrMix + 1 : countOfMoveOrMix
                }
                index -= 1
            }
        } while (countOfMoveOrMix > 0)
        
        return self
    }
}

extension Array where Element == [Cell] {
    
    /// Pushes each `Element` which is of type `[Cell]`.
    ///
    /// This is a convenience method to make working with `[[Cell]]` instances easier.
    mutating func pushRowsInPlace() {
        for (index, cells) in self.enumerated() {
            self[index] = cells.push()
        }
    }
    
    /// Pushes each `Element` which is of type `[Cell]` in reverse order.
    ///
    /// This is a convenience method to make working with `[[Cell]]` instances easier.
    mutating func pushRowsInPlaceReverse() {
        for (index, cells) in self.enumerated() {
            self[index] = cells.pushReverse()
        }
    }

    /// A convenience method to reverse each row, which is of type `[Cell]`, in-place.
    mutating func reverseRowsInPlace() {
        for (index, cells) in self.enumerated() {
            self[index] = cells.reversed()
        }
    }
}
