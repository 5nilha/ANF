//
//  RequestManager.swift
//  ANF Code Test
//
//  Created by Fabio Quintanilha on 8/13/22.
//

import Foundation
    
class RequestManager {
    class func request(_ method: HttpMethod,
                       url: String,
                       headers: [String: String]? = nil,
                       queryParams: [String: String]? = nil,
                       body: Data? = nil,
                       maxAttempts: Int = 1,
                       timeout: Double = 60.0,
                       cachePolicy: NSURLRequest.CachePolicy = NSURLRequest.CachePolicy.reloadIgnoringLocalCacheData,
                       completion: @escaping HttpRequestHandler) {
        
        let httpRequest: HttpRequest = HttpRequest()
        httpRequest.setConfiguration(maxAttempts: maxAttempts, cachePolicy: cachePolicy, timeout: timeout)
        httpRequest.getRequest(method,
                               url: url,
                               headers: headers,
                               queryParams: queryParams,
                               body: body,
                               completion: completion)
        
    }
    
    
    class func filePath(from resource: String, ofType: String?, for aClass: AnyClass) throws -> String {
        guard let path = Bundle(for: aClass).path(forResource: resource, ofType: ofType) else {
            throw RequestError.fileNotFound
        }
        return path
    }
    
    class func fileRequest<T>(_ dataType: T.Type, fileName: String, ofType: String?, completion: @escaping (Result<T, RequestError>) -> ()) where T: Decodable {
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
