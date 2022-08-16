//
//  CategoryExplorerHelper.swift
//  ANF Code Test
//
//  Created by Fabio Quintanilha on 8/14/22.
//

import Foundation

class CategoryExplorerHelper {
    
    var categoryExplorerViewModel: CategoryExplorerViewModel?
    let service = ExporeDataService()
    
    func fetchCategoriesFromFile(delegate: CategoryExplorerDelegate?) {
        service.delegate = delegate
        service.requestFromFile()
    }
    
    func fetchCategoriesFromNetwork(delegate: CategoryExplorerDelegate?) {
        service.delegate = delegate
        service.requestData()
    }
}
