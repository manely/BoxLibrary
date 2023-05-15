//
//  File.swift
//  
//
//  Created by Mani Hamedani on 4/11/23.
//

import Foundation

/// Defines a box containing an integer value.
struct Box: Equatable, CustomStringConvertible, CustomDebugStringConvertible, Hashable {
    var value: UInt
    
    /// Returns the sum of the `value` properties of this instance and `other`, if the values are equal,
    /// otherwise returns `nil`.
    func mix(with other: Box) -> Box? {
        guard self.value == other.value else {
            return nil
        }
        return Box(value: self.value + other.value)
    }
 
    var description: String {
        String(value)
    }
    
    var debugDescription: String {
        String(value)
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(value)
    }
    
    /// Two box objects are equal if they have equal `value` properties.
    static func ==(_ lhs: Box, rhs: Box) -> Bool {
        return lhs.value == rhs.value
    }
}
