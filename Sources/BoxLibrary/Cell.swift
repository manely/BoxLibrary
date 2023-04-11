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
}
