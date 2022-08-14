//
//  MockRequestManager.swift
//  ANF Code TestTests
//
//  Created by Fabio Quintanilha on 8/13/22.
//

import Foundation
@testable import ANF_Code_Test

class MockRequestManager: RequestManager {
    
    class func fileRequest<T>(_ dataType: T.Type, fileName: String, completion: (Result<T, RequestError>) -> ()) where T : Decodable {
        super.fileRequest(dataType, fileName: fileName, ofType: nil, completion: completion)
    }
    
    class func filePath(from resource: String, ofType: String?) throws -> String {
        try super.filePath(from: resource, ofType: ofType, for: self)
    }
}
