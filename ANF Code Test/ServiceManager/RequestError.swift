//
//  RequestError.swift
//  ANF Code Test
//
//  Created by Fabio Quintanilha on 8/13/22.
//

import Foundation

enum RequestError: Error {
    case fileNotFound
    case decodeError(Error)
    case fileDataConversionError(Error)
    case urlRequestCouldNotBeCreated
    case responseDataIsNil
    case httpCodeNotSuccessful
    case server(Error)
    case unknown(Error?)
}
