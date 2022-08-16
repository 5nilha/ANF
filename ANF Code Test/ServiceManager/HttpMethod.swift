//
//  HttpMethod.swift
//  ANF Code Test
//
//  Created by Fabio Quintanilha on 8/16/22.
//

import Foundation

enum HttpHeaders {
    case contentType
    
    var header: [String : String] {
        return [self.key : self.value]
    }
    
    private var value: String {
        return "application/json"
    }
    
    private var key: String {
        return "Content-Type"
    }
}

enum HttpMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case patch = "PATCH"
    case delete = "DELETE"
    
    var baseHeaders: [String : String]? {
        switch self {
        case .get:
            return nil
        default:
            return HttpHeaders.contentType.header
        }
    }
}
