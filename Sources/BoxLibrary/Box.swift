//
//  File.swift
//  
//
//  Created by Mani Hamedani on 4/11/23.
//

import Foundation

struct Box: Equatable {
    var value: UInt
    
    func mix(with other: Box) -> Box? {
        guard self.value == other.value else {
            return nil
        }
        return Box(value: self.value + other.value)
    }
    
    static func ==(_ lhs: Box, rhs: Box) -> Bool {
        return lhs.value == rhs.value
    }
}
