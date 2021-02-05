//
//  Enviroment.swift
//  KynhongIOSBase
//
//  Created by Kynhong on 1/31/21.
//

import Foundation

enum Environment {
    case development
    case testing
    case staging
    case production
    
    var apiDomain: String {
        switch self {
        case .development:
            return ServerDomain.development.apiDomain
        case .testing:
            return ServerDomain.testing.apiDomain
        case .staging:
            return ServerDomain.staging.apiDomain
        case .production:
            return ServerDomain.production.apiDomain
        }
    }
    
    var mediaDomain: String {
        switch self {
        case .development:
            return ServerDomain.development.mediaDomain
        case .testing:
            return ServerDomain.testing.mediaDomain
        case .staging:
            return ServerDomain.staging.mediaDomain
        case .production:
            return ServerDomain.production.mediaDomain
        }
    }
    
    var apiURL: String {
        switch self {
        case .development:
            return ServerDomain.development.apiURL
        case .testing:
            return ServerDomain.testing.apiURL
        case .staging:
            return ServerDomain.staging.apiURL
        case .production:
            return ServerDomain.production.apiURL
        }
    }
    
    var mediaURL: String {
        switch self {
        case .development:
            return ServerDomain.development.mediaURL
        case .testing:
            return ServerDomain.testing.mediaURL
        case .staging:
            return ServerDomain.staging.mediaURL
        case .production:
            return ServerDomain.production.mediaURL
        }
    }
}
