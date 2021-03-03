//
//  MainViewController.swift
//  KynhongIOSBase
//
//  Created by Kynhong on 03/03/2021.
//

import Foundation
import UIKit
import RxSwift

class MainViewController: PageViewController, TabbarDelegate {

    @IBOutlet weak var viewContainerPage: UIView!
    
    @IBOutlet weak var tabbar: Tabbar! {
        didSet {
            tabbar.delegate = self
        }
    }
    
    override var currentSelected: Int {
        didSet {
            super.currentSelected = currentSelected
            self.tabbar.selectedIndex = currentSelected
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func didSelectItem(at index: Int) {
        self.currentSelected = index
    }
    
    override func setupUI() {
        super.setupUI()
        self.prepareViewControllers()
    }
    
    fileprivate func prepareViewControllers() {
        let homeVC = Storyboard.initStoryboard.value.instantiate(HomeViewController.self)
        let homeViewModel = HomeViewModel()
        homeVC.viewModel = homeViewModel
        
        let home2VC = Storyboard.initStoryboard.value.instantiate(Home2ViewController.self)
        let home2ViewModel = Home2ViewModel()
        home2VC.viewModel = home2ViewModel
        
        let home3VC = Storyboard.initStoryboard.value.instantiate(Home3ViewController.self)
        let home3ViewModel = Home3ViewModel()
        home3VC.viewModel = home3ViewModel
        
        let home4VC = Storyboard.initStoryboard.value.instantiate(Home4ViewController.self)
        let home4ViewModel = Home4ViewModel()
        home4VC.viewModel = home4ViewModel
        
        self.addPageView(in: self.viewContainerPage, viewControllers: [homeVC, home2VC, home3VC, home4VC])
    }
}

