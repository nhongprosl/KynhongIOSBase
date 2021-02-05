//
//  BackendError.swift
//  KynhongIOSBase
//
//  Created by Kynhong on 2/2/21.
//

import Foundation

struct BackendError: Codable {
    let error: String
    let errorDescription: String?
    let code: String?
    
    enum CodingKeys: String, CodingKey {
        case error
        case errorDescription
        case code
    }
}
