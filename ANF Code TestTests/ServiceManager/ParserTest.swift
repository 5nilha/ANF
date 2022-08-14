//
//  ParserTest.swift
//  ANF Code TestTests
//
//  Created by Fabio Quintanilha on 8/13/22.
//

import XCTest
@testable import ANF_Code_Test

class ParserTest: XCTestCase {
    
    let resource = "Category_all_properties"

    func testFetchData() {
        do {
            let path = try MockRequestManager.filePath(from: resource, ofType: "json")
            let data = try ParserManager.fetchData(path)
            XCTAssertNotNil(data)
        } catch {
            XCTFail("\(error)")
        }
    }
    
    func testDecode() {
        let category = CategoryExplorer(title: "TOPS STARTING AT $12",
                                        backgroundImage: "http://www.abercrombie.com/anf/media/legalText/viewDetailsText20160602_Tier_Promo_US.html")
        do {
            let data = try JSONEncoder().encode(category)
            let decodedData = try ParserManager.decode(CategoryExplorer.self, data: data)
            XCTAssertEqual(decodedData.title, category.title)
            XCTAssertEqual(decodedData.backgroundImage, category.backgroundImage)
        } catch {
            XCTFail()
        }
    }

}
