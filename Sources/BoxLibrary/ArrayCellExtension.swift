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
    /// This method is used in `[[Cell]].pushRowsInPlace()` method, where it needs to push the cells from the first to the last of each row separately.
    ///
    func push() {
        var countOfMoveOrMix = 0
        
        repeat {
            countOfMoveOrMix = 0
            for (index, cell) in self.enumerated() {
                guard index + 1 < self.count else {
                    break
                }
                let nextCell = self[index + 1]
                let resultOfPush = cell.push(to: nextCell)
                if resultOfPush {
                    countOfMoveOrMix = resultOfPush ? countOfMoveOrMix + 1 : countOfMoveOrMix
                }
            }
        } while (countOfMoveOrMix > 0)
    }
    
    /// Pushes the cells of this instance, one by one, to the cells of `other`.
    ///
    /// If the result of pushing cells of `self` and `other` at each index is `true`, a counter for that row is increased by one.
    /// The returning array of this method contains the move-and-mix counters at each index.
    ///
    /// All the changes are taken in-place.
    ///
    /// This method is used in the `[[Cell]].pushInPlace()` method, where it needs to push its rows from first to last.
    ///
    /// - returns   An array of `Int` holding the count of move or mix separately for the cells of `self` and `other` at each index.
    func push(to other: [Element]) -> [Int] {
        var countOfMoveOrMix = Array<Int>(repeating: 0, count: CountOfCellsInARowOrColumn)
        
        for cellIndex in 0..<CountOfCellsInARowOrColumn {
            let cell = self[cellIndex]
            let nextCell = other[cellIndex]
            let resultOfPush = cell.push(to: nextCell)
            if resultOfPush {
                countOfMoveOrMix[cellIndex] = resultOfPush ? countOfMoveOrMix[cellIndex] + 1 : countOfMoveOrMix[cellIndex]
            }
        }
        
        return countOfMoveOrMix
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
    /// This method is used in the `[[Cell]].pushRowsInPlaceReverse()` method, where it needs to push the cells from the last to the first of each row separately.
    ///
    func pushReverse() {
        var countOfMoveOrMix = 0
        
        repeat {
            countOfMoveOrMix = 0
            var index = self.count - 1
            for cell in self.reversed() {
                guard index > 0 else {
                    break
                }
                let nextCell = self[index - 1]
                let resultOfPush = cell.push(to: nextCell)
                if resultOfPush {
                    countOfMoveOrMix = resultOfPush ? countOfMoveOrMix + 1 : countOfMoveOrMix
                }
                index -= 1
            }
        } while (countOfMoveOrMix > 0)
    }
}

extension Array<Int> {
    /// Helper method used in `[[Cell]].pushInPlace()` method.
    fileprivate func haveAtLeastOneElementGreaterThanZero() -> Bool {
        for value in self {
            if value > 0 {
                return true
            }
        }
        return false
    }
}

extension Array: Identifiable where Element == Cell {
    
    /// Returns the one and only one non-empty cell in this instance, otherwise `nil`.
    var oneAndOnlyNoneEmptyCell: Element? {
        var result: Element?
        for element in self {
            if !element.isEmpty {
                if result == nil {
                    result = element
                }
                else {
                    result = nil
                    break
                }
            }
        }
        return result
    }
    
    static var identifierFactory: Int = 0
    
    static func generateIdentifier() -> Int {
        identifierFactory += 1
        return identifierFactory
    }
    
    public var id: Int {
        return Self.generateIdentifier()
    }
}

extension Array where Element == [Cell] {
    
    /// Pushes each `Element` which is of type `[Cell]`.
    ///
    /// This is a convenience method to make working with `[[Cell]]` instances easier.
    func pushRowsInPlace() {
        for cells in self {
            cells.push()
        }
    }
    
    /// Pushes each `Element` which is of type `[Cell]` in reverse order.
    ///
    /// This is a convenience method to make working with `[[Cell]]` instances easier.
    func pushRowsInPlaceReverse() {
        for cells in self {
            cells.pushReverse()
        }
    }
    
    /// A convenience method to reverse each row, which is of type `[Cell]`, in-place.
    mutating func reverseRowsInPlace() {
        for (index, cells) in self.enumerated() {
            self[index] = cells.reversed()
        }
    }
    
    
    /// Pushes the rows of this instance, starting fom pushing the first row to the second, then the second to the
    /// third, and continue until the last row. This method is used in the implementation of `Table.push(direction:)`
    /// when the input argument is set to `.top`.
    ///
    /// The process is repeated again if there is at least one move, or move and mix in each phase. This can be determined
    /// by sending the message `haveAtLeastOneElementGreaterThanZero` to the returned array of `[Cell].push(to:)` method which is of type `[Int]`.
    ///
    /// All the changes are taken in-place.
    ///
    func pushInPlace() {
        var countOfMoveOrMixInRow = Array<Int>(repeating: 0, count: CountOfCellsInARowOrColumn)
        
        repeat {
            countOfMoveOrMixInRow = Array<Int>(repeating: 0, count: CountOfCellsInARowOrColumn)
            for (index, row) in self.enumerated() {
                guard index + 1 < self.count else {
                    break
                }
                let nextRow = self[index + 1]
                let temp = row.push(to: nextRow)
                countOfMoveOrMixInRow += temp
            }
        } while (countOfMoveOrMixInRow.haveAtLeastOneElementGreaterThanZero())
    }
    
    /// Pushes the rows of this instance, starting fom pushing the first row to the second, then the second to the
    /// third, and continue until the last row. This method is used in the implementation of `Table.push(direction:)`
    /// when the input argument is set to `.top`.
    ///
    /// The process is repeated again if there is at least one move, or move and mix in each phase. This can be determined
    /// by sending the message `haveAtLeastOneElementGreaterThanZero` to the returned array of `[Cell].push(to:)` method which is of type `[Int]`.
    ///
    /// All the changes are taken in-place.
    ///
    func pushInPlaceReverse() {
        var countOfMoveOrMixInRow = Array<Int>(repeating: 0, count: CountOfCellsInARowOrColumn)
        
        repeat {
            countOfMoveOrMixInRow = Array<Int>(repeating: 0, count: CountOfCellsInARowOrColumn)
            var index = self.count - 1
            for row in self.reversed() {
                guard index > 0 else {
                    break
                }
                let nextRow = self[index - 1]
                let temp = row.push(to: nextRow)
                countOfMoveOrMixInRow += temp
                index -= 1
            }
        } while (countOfMoveOrMixInRow.haveAtLeastOneElementGreaterThanZero())
    }
}
