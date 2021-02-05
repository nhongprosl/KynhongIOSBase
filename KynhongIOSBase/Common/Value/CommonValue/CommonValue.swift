//
//  CommonValue.swift
//  KynhongIOSBase
//
//  Created by Kynhong on 1/31/21.
//

import Foundation
import UIKit
import RxSwift

let disposeBag = DisposeBag()

let appstoreID = ""
let appstoreLink = ""

let defaultAvatar = "defaultAvatar.jpg"

// MARK: - Device Id
var deviceId: String {
    if let uuid = UIDevice.current.identifierForVendor?.uuidString {
        return uuid
    } else {
        return "unknown"
    }
}

// MARK: - Device Type
var deviceType: String {
    #if os(iOS)
    return "iOS"
    #elseif os(watchOS)
    return "watchOS"
    #elseif os(tvOS)
    return "tvOS"
    #elseif os(macOS)
    return "macOS"
    #elseif os(OSX)
    return "OSX"
    #else
    return "Apple"
    #endif
}

// MARK: - Client Type
var clientType: String {
    return "App"
}

//MARK: - Client Version
var clientVersion: String {
    let version = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String
    let buildNumber = Bundle.main.object(forInfoDictionaryKey: kCFBundleVersionKey as String) as? String
    if version == nil || (version?.isEmpty ?? true) {
        return "unknown"
    } else {
        return "\(version ?? "0.0.0").\(buildNumber ?? "0")"
    }
}

// MARK: - JSON decoder
var jsonDecoder: JSONDecoder {
    let decoder = JSONDecoder()
    return decoder
}

var jsonEncoder: JSONEncoder {
    let encoder = JSONEncoder()
    return encoder
}


