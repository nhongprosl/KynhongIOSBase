//
//  PopupPosition.swift
//  KynhongIOSBase
//
//  Created by Kynhong on 1/30/21.
//

import Foundation
import UIKit

enum PopupPosition {
    case center
    case top
    case bottom
    case topOfView(view: UIView, offset: CGFloat)
    case bottomOfView(view: UIView, offset: CGFloat)
    
    var view: UIView? {
        switch self {
        case .topOfView(let view, _):
            return view
        case .bottomOfView(let view, _):
            return view
        default:
            return nil
        }
    }
    
    var offset: CGFloat {
        switch self {
        case .topOfView(_, let offset):
            return offset
        case .bottomOfView(_, let offset):
            return offset
        default:
            return 0
        }
    }
}
