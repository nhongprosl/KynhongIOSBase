//
//  Status.swift
//  KynhongIOSBase
//
//  Created by Kynhong on 2/4/21.
//

import Foundation
import UIKit

enum Status {
    case warning
    case fail
    case success
    case info
    
    fileprivate var iconName: String {
        switch self {
        case .fail:
            return "ic_fail"
        case .warning:
            return "ic_warning"
        case .success:
            return "ic_success"
        case .info:
            return "ic_info"
        }
    }
    
    func icon(_ style: Style = .light) -> UIImage? {
        switch style {
        case .light:
            return UIImage(named: "ic_topopup")
        case .dark:
            return UIImage(named: "ic_topopup")
        }
    }
}
