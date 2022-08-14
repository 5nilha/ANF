//
//  Category.swift
//  ANF Code Test
//
//  Created by Fabio Quintanilha on 8/13/22.
//

import Foundation

struct CategoryExplorer: Codable {
    let title: String
    let backgroundImage: String
    private (set) var content: [Content]?
    private (set) var promoMessage: String?
    private (set) var topDescription: String?
    private (set) var bottomDescription: String?
}
