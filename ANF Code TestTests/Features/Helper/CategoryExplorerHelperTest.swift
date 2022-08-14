//
//  CategoryExplorerHelperTest.swift
//  ANF Code TestTests
//
//  Created by Fabio Quintanilha on 8/14/22.
//

import XCTest
@testable import ANF_Code_Test

class CategoryExplorerHelperTest: XCTestCase, CategoryExplorerDelegate {
    var helper: CategoryExplorerHelper?

    override func setUp() {
        super.setUp()
        helper = CategoryExplorerHelper()
        helper?.delegate = self
    }
    
    func didLoad(categories: [CategoryExplorerViewModel]) {
        XCTAssertTrue(categories.count == 10)
        XCTAssertEqual(categories[0].title, "TOPS STARTING AT $12")
        XCTAssertNotNil(categories[0].backgroundImage)
        XCTAssertEqual(categories[0].promoMessage, "USE CODE: 12345")
        XCTAssertEqual(categories[0].topDescription, "A&F ESSENTIALS")
        XCTAssertEqual(categories[0].bottomDescription, "*In stores & online. <a href=\\\"http://www.abercrombie.com/anf/media/legalText/viewDetailsText20160602_Tier_Promo_US.html\\\">Exclusions apply. See Details</a>")
    }
    
    func didFail(error: RequestError) {
        XCTAssertNil(error)
    }
    
    func testDelegateNotNil() {
        XCTAssertNotNil(helper?.delegate)
    }
    
    func testFetchCategories() {
        helper?.fetchCategories()
    }
}
