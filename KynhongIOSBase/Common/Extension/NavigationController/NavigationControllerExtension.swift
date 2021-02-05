//
//  NavigationControllerExtension.swift
//  KynhongIOSBase
//
//  Created by Kynhong on 2/5/21.
//

import Foundation
import UIKit

extension UINavigationController {
    func back(beforeOf: UIViewController.Type ) {
        var lastViewController: UIViewController?
        var viewControllerForPop: UIViewController?
        for i in 0..<self.viewControllers.count {
            let viewController = self.viewControllers[i]
            if viewController.isKind(of: beforeOf) {
                viewControllerForPop = lastViewController
                break
            }
            lastViewController = viewController
        }
        if let vc = viewControllerForPop {
            self.popToViewController(vc, animated: true)
        }
        
    }
    
    func back(to viewControllerType: UIViewController.Type) {
        var viewControllerForPop: UIViewController?
        for i in 0..<self.viewControllers.count {
            let viewController = self.viewControllers[i]
            if viewController.isKind(of: viewControllerType) {
                viewControllerForPop = viewController
                break
            }
        }
        if let vc = viewControllerForPop {
            self.popToViewController(vc, animated: true)
        }
    }
    
    func isContain(_ viewControllerType: UIViewController.Type) -> Bool {
        for i in 0..<self.viewControllers.count {
            let viewController = self.viewControllers[i]
            if viewController.isKind(of: viewControllerType) {
                return true
            }
        }
        return false
    }
}
