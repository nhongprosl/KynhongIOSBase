//
//  Scene.swift
//  KynhongIOSBase
//
//  Created by Kynhong on 1/27/21.
//

import Foundation
import UIKit

enum Scene: String {
    case initView = "initView"
    
    func getViewController(_ inititalData: Any? = nil) -> ViewController {
        let viewControllerType = self.viewController
        let viewController = self.storyboard.value.instantiate(viewControllerType)
        let viewModelType = self.viewModel
        let viewModel = viewModelType.init(inititalData)
        viewController.viewModel = viewModel
        return viewController
    }
    
    var showType: ShowType {
        switch self {
        case .initView:
            return .root
        }
    }
    
    fileprivate var viewModel: ViewModel.Type {
        switch self {
        case .initView:
            return InitViewModel.self
        }
    }
    
    fileprivate var storyboard: Storyboard {
        switch self {
        case .initView:
            return Storyboard.initStoryboard
        }
    }
    
    fileprivate var viewController: ViewController.Type {
        switch self {
        case .initView:
            return InitViewController.self
        }
    }
    
}
