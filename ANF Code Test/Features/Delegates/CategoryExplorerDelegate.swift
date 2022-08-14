//
//  CategoryExplorerDelegate.swift
//  ANF Code Test
//
//  Created by Fabio Quintanilha on 8/14/22.
//

import Foundation

protocol CategoryExplorerDelegate: AnyObject {
    func didLoad(categories: [CategoryExplorerViewModel])
    func didFail(error: RequestError)
}
