//
//  BundleExtension.swift
//  KynhongIOSBase
//
//  Created by Kynhong on 2/4/21.
//

import Foundation
import UIKit

extension Bundle {
    
    func loadView<T: UIView>(with className: T.Type) -> T {
        return self.loadNibNamed(String(describing: className), owner: nil, options: nil)?.first as! T
    }
    
    var version: String? {
        return self.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String
    }
    
    var buildNumber: String? {
        return self.object(forInfoDictionaryKey: kCFBundleVersionKey as String) as? String
    }
}

