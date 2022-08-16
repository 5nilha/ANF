//
//  Identifiable.swift
//  ANF Code Test
//
//  Created by Fabio Quintanilha on 8/16/22.
//

import Foundation

/* Conforming Cell classes with Identifiable protocol
*  will automatically create an identifier using class name
*  Eg: for Class TestCell, the identifier will be "TestCell
*/
protocol Identifiable: AnyObject {
    static var identifier: String { get }
    var identifier: String { get }
}

extension Identifiable {

    static var identifier: String { "\(self)" }

    var identifier: String {
        Self.identifier
    }
}
