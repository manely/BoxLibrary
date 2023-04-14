//
//  File.swift
//  
//
//  Created by Mani Hamedani on 4/11/23.
//

import Foundation

// TODO: add documentation; write about cells equality criteria
// TODO: remember to make the code more Swifty, by using protocols, property wrappers, property observers, ...
// using protocols and extensions may help reduce the code in Array<Cell> extension;
// with a Pushable protocol, and have Cell and [Cell] both conform to it.
final class Cell: Equatable, CustomDebugStringConvertible {
    let table: Table
    var box: Box?
    
    init(table: Table, box: Box? = nil) {
        self.table = table
        self.box = box
    }
    
    /// Returns `true` when `box` property is `nil`.
    var isEmpty: Bool {
        box == nil
    }
    
    var debugDescription: String {
        self.box?.debugDescription ?? "empty"
    }
    
    /// Pushed the contents (the `Box` object) of `self` to `other`. If a move or move and mix happens, this method returns `true`.
    ///
    /// The meaning of move is that a non-empty cell pushes its contents to its next empty cell; the non-empty cells becomes empty. A
    /// move and mix is happened when a non-empty cell is pushed to a its adjacent non-empty cell, where their contents are equal. In this case,
    /// the first cell becomes empty and the next one holds the sum of those equal contents.
    ///
    /// - parameters
    ///     - `other` The other cell to push the contents to
    /// - returns `true` if a move or a move and mix is happened, otherwise `false`.
    ///
    func push(to other: Cell) -> Bool {
        assert (self !== other)
        guard let box else {
            // self is empty, so return false
            return false
        }
        guard let otherBox = other.box else {
            // self is non-empty, while other is empty; a move is occured
            other.box = self.box
            self.box = nil
            return true
        }
        if let mixed = box.mix(with: otherBox) {
            // Both self and other are non-empty with equal contents; a move and mix is occured
            other.box = mixed
            self.box = nil
            return true
        }
        return false
    }
    
    // MARK: - Equatable
    
    static func ==(_ lhs: Cell, _ rhs: Cell) -> Bool {
        return lhs.table === rhs.table && lhs.box == rhs.box
    }
}
