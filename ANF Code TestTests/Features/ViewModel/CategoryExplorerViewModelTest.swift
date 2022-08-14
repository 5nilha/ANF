//
//  CategoryExplorerViewModelTest.swift
//  ANF Code TestTests
//
//  Created by Fabio Quintanilha on 8/14/22.
//

import XCTest
@testable import ANF_Code_Test

class CategoryExplorerViewModelTest: XCTestCase {

    var categoryExplorer: CategoryExplorer {
        return CategoryExplorer(title: "Test Category",
                                backgroundImage: "anf-20160527-app-m-shirts.jpg",
                                content: [Content(target: "https://www.abercrombie.com/shop/us/mens-new-arrivals",
                                                  title: "Content title test")],
                                promoMessage: "Promo-message test",
                                topDescription: "Top-description test",
                                bottomDescription: "Bottom-description test")
    }
    
    var categoryExplorerViewModel: CategoryExplorerViewModel?
    
    override func setUp() {
        super.setUp()
        categoryExplorerViewModel = CategoryExplorerViewModel(categoryExplorer)
    }

    func testViewModelTitle() {
        XCTAssertEqual(categoryExplorerViewModel?.title, "Test Category")
    }
    
    func testViewModelBackgroundImage() {
        XCTAssertNotNil(categoryExplorerViewModel?.backgroundImage)
    }
    
    func testViewModelPromoMessage() {
        XCTAssertEqual(categoryExplorerViewModel?.promoMessage, "Promo-message test")
    }
    
    func testViewModelTopDescription() {
        XCTAssertEqual(categoryExplorerViewModel?.topDescription, "Top-description test")
    }
    
    func testViewModelBottomDescription() {
        XCTAssertEqual(categoryExplorerViewModel?.bottomDescription, "Bottom-description test")
    }

}
