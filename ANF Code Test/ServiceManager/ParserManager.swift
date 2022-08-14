//
//  ParserManager.swift
//  ANF Code Test
//
//  Created by Fabio Quintanilha on 8/14/22.
//

import Foundation

class ParserManager {
    
    class func fetchData(_ path: String) throws -> Data {
        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: path))
            return data
        } catch {
            throw RequestError.fileDataConversionError(error)
        }
    }
    
    class func decode<T>(_ dataType: T.Type, data: Data) throws -> T where T: Decodable {
        do {
            let decodedData = try JSONDecoder().decode(dataType.self, from: data)
            return decodedData
        } catch {
            throw RequestError.decodeError(error)
        }
    }
}
