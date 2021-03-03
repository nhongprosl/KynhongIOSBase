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
    case main = "main"
    case home = "home"
    case home2 = "home2"
    case home3 = "home3"
    case home4 = "home4"
    
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
        case .initView, .main:
            return .root
        case .home:
            return .embedded(index: 0, in: .main)
        case .home2:
            return .embedded(index: 1, in: .main)
        case .home3:
            return .embedded(index: 2, in: .main)
        case .home4:
            return .embedded(index: 3, in: .main)
        }
    }
    
    fileprivate var viewModel: ViewModel.Type {
        switch self {
        case .initView:
            return InitViewModel.self
        case .main:
            return MainViewModel.self
        case .home:
            return HomeViewModel.self
        case .home2:
            return Home2ViewModel.self
        case .home3:
            return Home3ViewModel.self
        case .home4:
            return Home4ViewModel.self
        }
    }
    
    fileprivate var storyboard: Storyboard {
        switch self {
        case .initView, .main, .home, .home2, .home3, .home4:
            return Storyboard.initStoryboard
        }
    }
    
    fileprivate var viewController: ViewController.Type {
        switch self {
        case .initView:
            return InitViewController.self
        case .main:
            return MainViewController.self
        case .home:
            return HomeViewController.self
        case .home2:
            return Home2ViewController.self
        case .home3:
            return Home3ViewController.self
        case .home4:
            return Home4ViewController.self
        }
    }
    
}
