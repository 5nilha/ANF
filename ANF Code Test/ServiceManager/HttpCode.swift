//
//  HttpCode.swift
//  ANF Code Test
//
//  Created by Fabio Quintanilha on 8/16/22.
//

import Foundation

enum HttpCode: Int, Equatable {
    case ok = 200
    case created = 201
    case accepted = 202
    case nonAuthoritativeInfo = 203
    case noContent = 204
    case resetContent = 205
    case partialContent = 206
    case badRequest = 400
    case unauthorized = 401
    case forbidden = 403
    case notFound = 404
    case methodNotAllowed = 405
    case notAcceptable = 406
    case proxyAuthenticationRequired = 407
    case timeout = 408
    case conflict = 409
    case payloadTooLarge = 413
    case uriTooLong = 414
    case unsupportedMediaType = 415
    case serverError = 500
    
    var isSuccess: Bool {
        switch self {
        case .ok, .created, .noContent:
            return true
        default:
            return false
        }
    }
}
