//
//  ServerDomain.swift
//  KynhongIOSBase
//
//  Created by Kynhong on 1/31/21.
//

import Foundation

enum ServerDomain {
    case development
    case testing
    case staging
    case production
    
    var apiDomain: String {
        switch self {
        case .development:
            return "kynhong.com"
        case .testing:
            return "kynhong.com"
        case .staging:
            return "kynhong.com"
        case .production:
            return "kynhong.com"
        }
    }
    
    var mediaDomain: String {
        switch self {
        case .development:
            return "kynhong.com"
        case .testing:
            return "kynhong.com"
        case .staging:
            return "kynhong.com"
        case .production:
            return "kynhong.com"
        }
    }
    
    var apiURL: String {
        switch self {
        case .development:
            return "https://kynhong.com"
        case .testing:
            return "https://kynhong.com"
        case .staging:
            return "https://kynhong.com"
        case .production:
            return "https://kynhong.com"
        }
    }
    
    var mediaURL: String {
        switch self {
        case .development:
            return "https://kynhong.com"
        case .testing:
            return "https://kynhong.com"
        case .staging:
            return "https://kynhong.com"
        case .production:
            return "https://kynhong.com"
        }
    }
}

