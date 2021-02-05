//
//  Storyboard.swift
//  KynhongIOSBase
//
//  Created by Kynhong on 1/27/21.
//

import Foundation
import UIKit

enum Storyboard {
    case initStoryboard
    
    fileprivate var name: String {
        switch self {
        case .initStoryboard:
            return "Init"
        }
    }
    
    var value: UIStoryboard {
        return UIStoryboard(name: self.name, bundle: nil)
    }
}
