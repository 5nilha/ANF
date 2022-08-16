//
//  ExploreCardCell.swift
//  ANF Code Test
//
//  Created by Fabio Quintanilha on 8/15/22.
//

import UIKit

class ExploreCardCell: UITableViewCell {
    
    static let identifier = "exploreContentCell"
    @IBOutlet weak var categoryView: CategoryExplorerView?
    
    override func prepareForReuse() {
        super.prepareForReuse()
        categoryView?.resetView()
    }
    
    func setupView(categoryExplorerVM: CategoryExplorerViewModel) {
        categoryView?.title = categoryExplorerVM.title
        categoryView?.imageUrl = categoryExplorerVM.backgroundImageUrl
        categoryView?.topDescription = categoryExplorerVM.topDescription
        categoryView?.bottomDescription = categoryExplorerVM.bottomDescription
        categoryView?.promoMessage = categoryExplorerVM.promoMessage
        categoryView?.items = categoryExplorerVM.content
    }
}
