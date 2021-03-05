//
//  ViewController.swift
//  KynhongIOSBase
//
//  Created by Kynhong on 1/27/21.
//

import UIKit
import RxSwift
import RxKeyboard

class ViewController: UIViewController, StyleProtocol {
    let disposeBag = DisposeBag()
    @IBOutlet weak var tableView: UITableView?
//    @IBOutlet weak var navigationBar: NavigationBar?
//    @IBOutlet weak var bottomFunctionButton: BottomButton?
    @IBOutlet weak var bottomConstraintBottomButton: NSLayoutConstraint?
    @IBOutlet weak var noDataLabel: UILabel?
    
    var isIgnoreStyle: Bool = false
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
        if #available(iOS 13.0, *) {
            if self.traitCollection.hasDifferentColorAppearance(comparedTo: previousTraitCollection) {
                SceneManager.shared.style = self.getStyle()
                SceneManager.shared.styleObservable.onNext(self.getStyle())
                self.styleChanged(self.getStyle())
            }
        }
    }
    
    func setupStyle(_ style: Style) {
        self.setNeedsStatusBarAppearanceUpdate()
        if isIgnoreStyle {
            return
        }
    }
    
    func styleChanged(_ style: Style) {
        self.style = style
        self.setupStyle(style)
    }
    
    func getStyle() -> Style {
        if DataManager.shared.isAutoStyle {
            if #available(iOS 12.0, *) {
                let style = self.traitCollection.userInterfaceStyle
                switch style {
                case .light:
                    return .light
                case .dark:
                    return .dark
                case .unspecified:
                    return .light
                @unknown default:
                    return .light
                }
            } else {
                return DataManager.shared.styleConfigured
            }
        } else {
            return DataManager.shared.styleConfigured
        }
    }
    
    //MARK: Bind
    func bind() {
        self.viewModel.bind(self.tableView)
        self.noDataLabel?.isHidden = true
        self.viewModel.isNoData.subscribe(onNext: {[weak self] value in
            self?.noDataLabel?.isHidden = !value
        }).disposed(by: disposeBag)
        if self.bottomConstraintBottomButton != nil {
            RxKeyboard.instance.visibleHeight.drive(onNext: {[weak self] height in
                var sizeSafeAreaBottom: CGFloat = 0
                let keyWindow = UIApplication.shared.keyWindow
                let bottom = keyWindow?.safeAreaInsets.bottom ?? 0
                sizeSafeAreaBottom = bottom
                self?.bottomConstraintBottomButton?.constant = height > 0 ? height + 16 - sizeSafeAreaBottom : 24
                UIView.animate(withDuration: 0) {
                    self?.view.setNeedsLayout()
                    self?.view.layoutIfNeeded()
                }
            }).disposed(by: disposeBag)
        }
    }
    
    
}
