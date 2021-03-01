//
//  ViewController.swift
//  KynhongIOSBase
//
//  Created by Kynhong on 1/27/21.
//

import UIKit
import RxSwift

class ViewController: UIViewController, StyleProtocol {
    let disposeBag = DisposeBag()
    
    var style: Style = DataManager.shared.styleConfigured
    var viewModel: ViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
        self.bind()
    }
    
    
    func viewModel<T: ViewModel>(_ type: T.Type) -> T {
        return self.viewModel as! T
    }
    
    //MARK: setup UI
    func setupUI() {
//        self.style = self.getStyle()
//        SceneManager.shared.style = self.getStyle()
//        SceneManager.shared.styleObservable.onNext(self.getStyle())
        self.navigationController?.isNavigationBarHidden = true
    }
    
    //MARK: setup Style
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        
    }
    
    func setupStyle(_ style: Style) {
        self.setNeedsStatusBarAppearanceUpdate()
    }
    
    func styleChanged(_ style: Style) {
        self.style = style
        self.setupStyle(style)
    }
    
    //MARK: Bind
    func bind() {
        
    }
    
    
}
