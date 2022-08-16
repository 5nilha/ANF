//
//  Constants.swift
//  ANF Code Test
//
//  Created by Fabio Quintanilha on 8/16/22.
//

import Foundation

//MARK: Typealias
typealias RequestHandler = (Result<NSData, Error>) -> Void
typealias HttpRequestResponse = (data: Data?, httpCode: HttpCode?)
typealias HttpRequestHandler = (Result<HttpRequestResponse, RequestError>) -> Void
