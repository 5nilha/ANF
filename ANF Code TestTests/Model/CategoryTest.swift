//
//  CategoryTest.swift
//  ANF Code TestTests
//
//  Created by Fabio Quintanilha on 8/13/22.
//

import XCTest
@testable import ANF_Code_Test

class CategoryTest: XCTestCase {

    func testCategoryAllPropertiesFilled() {
        MockRequestManager.fileRequest(CategoryExplorer.self, fileName: "Category_all_properties.json") { result in
            switch result {
            case .success(let category):
                XCTAssertEqual(category.title, "TOPS STARTING AT $12")
                XCTAssertEqual(category.backgroundImage, "anf-20160527-app-m-shirts.jpg")
                XCTAssertEqual(category.title, "TOPS STARTING AT $12")
                XCTAssertEqual(category.content?.count, 2)
                XCTAssertEqual(category.content?[0].target, "https://www.abercrombie.com/shop/us/mens-new-arrivals")
                XCTAssertEqual(category.content?[0].title, "Shop Men")
                XCTAssertEqual(category.content?[1].target, "https://www.abercrombie.com/shop/us/womens-new-arrivals")
                XCTAssertEqual(category.content?[1].title, "Shop Women")
                XCTAssertEqual(category.promoMessage, "USE CODE: 12345")
                XCTAssertEqual(category.topDescription, "A&F ESSENTIALS")
                XCTAssertEqual(category.bottomDescription, "*In stores & online. <a href=\\\"http://www.abercrombie.com/anf/media/legalText/viewDetailsText20160602_Tier_Promo_US.html\\\">Exclusions apply. See Details</a>")
            case .failure(let error):
                XCTFail("\(#function) failed. Error:[\(error)]")
            }
        }
    }
    
    func testCategoryWithoutBottomDescription() {
        MockRequestManager.fileRequest(CategoryExplorer.self, fileName: "Category_without_bottom_description.json") { result in
            switch result {
            case .success(let category):
                XCTAssertEqual(category.title, "TOPS STARTING AT $12")
                XCTAssertEqual(category.backgroundImage, "anf-20160527-app-m-shirts.jpg")
                XCTAssertEqual(category.title, "TOPS STARTING AT $12")
                XCTAssertEqual(category.content?.count, 2)
                XCTAssertEqual(category.content?[0].target, "https://www.abercrombie.com/shop/us/mens-new-arrivals")
                XCTAssertEqual(category.content?[0].title, "Shop Men")
                XCTAssertEqual(category.content?[1].target, "https://www.abercrombie.com/shop/us/womens-new-arrivals")
                XCTAssertEqual(category.content?[1].title, "Shop Women")
                XCTAssertEqual(category.promoMessage, "USE CODE: 12345")
                XCTAssertEqual(category.topDescription, "A&F ESSENTIALS")
                XCTAssertNil(category.bottomDescription)
            case .failure(let error):
                XCTFail("\(#function) failed. Error:[\(error)]")
            }
        }
    }
    
    func testCategoryWithoutBottomAndTop() {
        MockRequestManager.fileRequest(CategoryExplorer.self, fileName: "Category_without_bottom_and_top.json") { result in
            switch result {
            case .success(let category):
                XCTAssertEqual(category.title, "TOPS STARTING AT $12")
                XCTAssertEqual(category.backgroundImage, "anf-20160527-app-m-shirts.jpg")
                XCTAssertEqual(category.title, "TOPS STARTING AT $12")
                XCTAssertEqual(category.content?.count, 2)
                XCTAssertEqual(category.content?[0].target, "https://www.abercrombie.com/shop/us/mens-new-arrivals")
                XCTAssertEqual(category.content?[0].title, "Shop Men")
                XCTAssertEqual(category.content?[1].target, "https://www.abercrombie.com/shop/us/womens-new-arrivals")
                XCTAssertEqual(category.content?[1].title, "Shop Women")
                XCTAssertEqual(category.promoMessage, "USE CODE: 12345")
                XCTAssertNil(category.topDescription)
                XCTAssertNil(category.bottomDescription)
            case .failure(let error):
                XCTFail("\(#function) failed. Error:[\(error)]")
            }
        }
    }

    func testCategory_NoPromoNoBottomAndTop() {
        MockRequestManager.fileRequest(CategoryExplorer.self, fileName: "Category_nopromo_nobottom_and_notop.json") { result in
            switch result {
            case .success(let category):
                XCTAssertEqual(category.title, "TOPS STARTING AT $12")
                XCTAssertEqual(category.backgroundImage, "anf-20160527-app-m-shirts.jpg")
                XCTAssertEqual(category.title, "TOPS STARTING AT $12")
                XCTAssertEqual(category.content?.count, 2)
                XCTAssertEqual(category.content?[0].target, "https://www.abercrombie.com/shop/us/mens-new-arrivals")
                XCTAssertEqual(category.content?[0].title, "Shop Men")
                XCTAssertEqual(category.content?[1].target, "https://www.abercrombie.com/shop/us/womens-new-arrivals")
                XCTAssertEqual(category.content?[1].title, "Shop Women")
                XCTAssertNil(category.promoMessage)
                XCTAssertNil(category.topDescription)
                XCTAssertNil(category.bottomDescription)
            case .failure(let error):
                XCTFail("\(#function) failed. Error:[\(error)]")
            }
        }
    }
    
}

