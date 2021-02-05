//
//  StoryboardExtension.swift
//  KynhongIOSBase
//
//  Created by Kynhong on 1/27/21.
//

import Foundation
import UIKit

extension UIStoryboard {
    func instantiate<T: UIViewController>(_ type: T.Type) -> T {
        let instance = self.instantiateViewController(withIdentifier: String(describing: type)) as! T
        return instance
    }
}

