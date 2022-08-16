//
//  Logger.swift
//  ANF Code Test
//
//  Created by Fabio Quintanilha on 8/16/22.
//

import Foundation

enum LogLevel {
    case info
    case error(Error? = nil)
    case debug
    case warning
    
    var description: String {
        switch self {
        case .error(let error):
            return "Error: [\(String(describing: error))]"
        case .warning:
            return "Info: Log warning"
        default:
            return "Info: Log information"
        }
    }
    
    var text: String {
        switch self {
        case .info:
            return "Info"
        case .error:
            return "Error"
        case .debug:
            return "Debug"
        case .warning:
            return "Warning"
        }
    }
}

class Logger {
    
    class func log(_ message: String,
                   logLevel: LogLevel = .info,
                   caller: String = #function) {
        let logString = """
                        \n
                        log_level: \(logLevel.text)\n
                        caller: \(caller)\n
                        occurency_at: \(Date())\n
                        \(logLevel.description)\n
                        log_message = \(message)
                        \n
                        """
        print(logString)
    }
}
