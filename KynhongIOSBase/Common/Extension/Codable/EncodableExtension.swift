//
//  EncodableExtension.swift
//  KynhongIOSBase
//
//  Created by Kynhong on 2/5/21.
//

import Foundation

extension Encodable {
    func jsonData() -> Data? {
        return try? jsonEncoder.encode(self)
    }
}

