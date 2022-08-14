//
//  CategoryExplorerViewModel.swift
//  ANF Code Test
//
//  Created by Fabio Quintanilha on 8/14/22.
//

import UIKit

struct CategoryExplorerViewModel {
    
    let categoryExplorer: CategoryExplorer
    
    init(_ categoryExplorer: CategoryExplorer) {
        self.categoryExplorer = categoryExplorer
    }
    
    var backgroundImage: UIImage? {
        let name = categoryExplorer.backgroundImage
        return UIImage(named: name)
    }
    
    var title: String {
        return categoryExplorer.title
    }
    
    var promoMessage: String? {
        return categoryExplorer.promoMessage
    }
    
    var topDescription: String? {
        return categoryExplorer.topDescription
    }

    var bottomDescription: String? {
        return categoryExplorer.bottomDescription
    }
}

