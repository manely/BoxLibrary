//
//  File.swift
//  
//
//  Created by Mani Hamedani on 4/11/23.
//

import Foundation

// TODO: add documentation; write about cells equality criteria
final class Cell: Equatable {
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
    /// - throws ``CellPushError.pushToItself`` if `self` is identical to `other`
    func push(to other: Cell) throws -> Bool {
        // FIXME: May be better to use assert instead of error
        guard self !== other else {
            throw CellPushError.pushToItself
        }
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

enum CellPushError: Error {
    case pushToItself
}
