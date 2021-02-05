//
//  TokenResponse.swift
//  KynhongIOSBase
//
//  Created by Kynhong on 1/31/21.
//

import Foundation

class TokenResponse: Codable {
    let accessToken: String
    
    enum CodingKeys: String, CodingKey {
        case accessToken = "accessToken"
    }
}

