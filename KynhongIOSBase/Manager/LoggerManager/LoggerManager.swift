//
//  LoggerManager.swift
//  KynhongIOSBase
//
//  Created by Kynhong on 2/2/21.
//

import Foundation

class LoggerManager {
    public static let shared = LoggerManager()
    
    class func addConsoleLog(_ message: String) {
        #if DEBUG
        print("[Kynhong log] - \(message)")
        #endif
    }
    
    func addErrorLog(url: String, message: String) {
        LoggerManager.addConsoleLog("\(url) - Response error | \(message)")
    }
    
    func addDataLog(url: String, data: Data) {
        if let object = try? JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed), let newData = try? JSONSerialization.data(withJSONObject: object, options: .prettyPrinted), let string = String(data: newData, encoding: .utf8) {
            LoggerManager.addConsoleLog("\(url) - Response data | \(string)")
        }
    }
    
    func addHeaderLog(url: String, headers: [String: String]) {
        if let data = try? JSONSerialization.data(withJSONObject: headers, options: .prettyPrinted), let string = String(data: data, encoding: .utf8) {
            LoggerManager.addConsoleLog("\(url) - Request header | \(string)")
        }
    }
    
    func addBodyLog(url: String, body: [String: Any]) {
        if let data = try? JSONSerialization.data(withJSONObject: body, options: .prettyPrinted), let string = String(data: data, encoding: .utf8) {
            LoggerManager.addConsoleLog("\(url) - Request body | \(string)")
        }
    }
}
