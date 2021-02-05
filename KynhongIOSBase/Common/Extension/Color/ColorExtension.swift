//
//  ColorExtension.swift
//  KynhongIOSBase
//
//  Created by Kynhong on 2/5/21.
//

import Foundation
import UIKit

extension UIColor {
    var cgFloatComponents: (red: CGFloat, green: CGFloat, blue: CGFloat) {
        var components: [CGFloat] {
            let comps = cgColor.components!
            if comps.count == 4 { return comps }
            return [comps[0], comps[0], comps[0], comps[1]]
        }
        let red = components[0]
        let green = components[1]
        let blue = components[2]
        return (red: red, green: green, blue: blue)
    }
    
    var alpha: CGFloat {
        return cgColor.alpha
    }
}
