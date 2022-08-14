//
//  CategoryExplorerHelper.swift
//  ANF Code Test
//
//  Created by Fabio Quintanilha on 8/14/22.
//

import Foundation

class CategoryExplorerHelper {
    
    weak var delegate: CategoryExplorerDelegate?
    var categoryExplorerViewModel: CategoryExplorerViewModel?
    
    //Call Service
    func fetchCategories() {
        RequestManager.fileRequest([CategoryExplorer].self, fileName: "exploreData", ofType: "json") { [weak self] result in
            switch result {
            case .success(let categories):
                let categoriesVM = categories.map { CategoryExplorerViewModel($0) }
                self?.delegate?.didLoad(categories: categoriesVM)
            case .failure(let error):
                self?.delegate?.didFail(error: error)
            }
        }
    }
}
