//
//  ViewController.swift
//  KynhongIOSBase
//
//  Created by Kynhong on 1/27/21.
//

import UIKit
import RxSwift

class ViewController: UIViewController {
    let disposeBag = DisposeBag()
    
    
    var viewModel: ViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func viewModel<T: ViewModel>(_ type: T.Type) -> T {
        return self.viewModel as! T
    }
    
}
