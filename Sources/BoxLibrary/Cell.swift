//
//  File.swift
//  
//
//  Created by Mani Hamedani on 4/11/23.
//

import Foundation

final class Cell {
    let table: Table
    var box: Box?
    
    init(table: Table, box: Box? = nil) {
        self.table = table
        self.box = box
    }
    
    /// Pushed the contents (the `Box` object) of current instance to `other`.
    /// - parameters
    ///     - `other` The other cell to push the contents to
    /// - throws ``CellPushError.pushToItself`` if `self` is identical to `other`
    func push(to other: Cell) throws {
        // FIXME: May be better to use assert instead of error
        guard self !== other else {
            throw CellPushError.pushToItself
        }
        guard let box else {
            return
        }
        guard let otherBox = other.box else {
            other.box = self.box
            self.box = nil
            return
        }
        if let mixed = box.mix(with: otherBox) {
            other.box = mixed
            self.box = nil
        }
    }
}

enum CellPushError: Error {
    case pushToItself
}
