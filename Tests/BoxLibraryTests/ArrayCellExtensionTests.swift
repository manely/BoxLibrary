//
//  File.swift
//  
//
//  Created by Mani Hamedani on 4/12/23.
//

import XCTest
@testable import BoxLibrary

final class ArrayCellExtensionTests: XCTestCase {
    let table = Table()
    let boxedOf2 = Box(value: 2)
    let boxedOf4 = Box(value: 4)
    var emptyCell1: Cell!
    var emptyCell2: Cell!
    var valuedCell2: Cell!
    var valuedCell2Other: Cell!
    var valuedCell4: Cell!
    var valuedCell4Other: Cell!

    override func setUp() {
        emptyCell1 = Cell(table: table)
        emptyCell2 = Cell(table: table)
        valuedCell2 = Cell(table: table, box: boxedOf2)
        valuedCell2Other = Cell(table: table, box: boxedOf2)
        valuedCell4 = Cell(table: table, box: boxedOf4)
        valuedCell4Other = Cell(table: table, box: boxedOf4)
    }

}
