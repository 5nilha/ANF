//
//  RequestManager.swift
//  ANF Code Test
//
//  Created by Fabio Quintanilha on 8/13/22.
//

import Foundation

enum HttpMethods: String {
    case get
    case post
    case patch
    case delete
}
    
class RequestManager {
    
    class func filePath(from resource: String, ofType: String?, for aClass: AnyClass) throws -> String {
        guard let path = Bundle(for: aClass).path(forResource: resource, ofType: ofType) else {
            throw RequestError.fileNotFound
        }
        return path
    }
    
    class func fileRequest<T>(_ dataType: T.Type, fileName: String, ofType: String?, completion: (Result<T, RequestError>) -> ()) where T: Decodable {
        do {
            let path = try filePath(from: fileName, ofType: ofType, for: self)
            let data = try ParserManager.fetchData(path)
            let parsedData = try ParserManager.decode(dataType.self, data: data)
            completion(.success(parsedData))
        } catch {
            let requestError = error as? RequestError ?? RequestError.unknown(error)
            completion(.failure(requestError))
        }
    }
    
}
