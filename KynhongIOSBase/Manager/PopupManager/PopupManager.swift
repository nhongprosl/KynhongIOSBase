//
//  PopupManager.swift
//  KynhongIOSBase
//
//  Created by Kynhong on 1/30/21.
//

import Foundation
import UIKit
import SnapKit

class PopupManager {
    public static let shared = PopupManager()
    var popups: [(backgroundView: UIView, contentView: UIView, position: PopupPosition)] = []
    
    @objc func dismiss(_ view: UIView? = nil, completion: (()->Void)? = nil) {
        if let currentView = view {
            var index: Int = -1
            for i in 0..<popups.count {
                let item = popups[i]
                if item.contentView == currentView {
                    index = i
                    break
                }
            }
            if index >= 0 && index < popups.count {
                let item = popups[index]
                let position = item.position
                let contentView = item.contentView
                let backgroundView = item.backgroundView
                popups.remove(at: index)
                switch position {
                case .top:
                    UIView.animate(withDuration: 0.5) {
                        backgroundView.alpha = 0.0
                        contentView.transform = CGAffineTransform(translationX: 0, y: -(contentView.frame.size.height))
                    } completion: { completed in
                        contentView.removeFromSuperview()
                        backgroundView.removeFromSuperview()
                        completion?()
                    }
                case .bottom:
                    UIView.animate(withDuration: 0.5) {
                        backgroundView.alpha = 0.0
                        contentView.transform = CGAffineTransform(translationX: 0, y: contentView.frame.size.height)
                    } completion: { completed in
                        contentView.removeFromSuperview()
                        backgroundView.removeFromSuperview()
                        completion?()
                    }

                case .center:
                    UIView.animate(withDuration: 0.5) {
                        backgroundView.alpha = 0.0
                        contentView.transform = CGAffineTransform(translationX: 0, y: contentView.frame.size.height + UIScreen.main.bounds.size.height/2)
                    } completion: { completed in
                        contentView.removeFromSuperview()
                        backgroundView.removeFromSuperview()
                        completion?()
                    }
                case .topOfView:
                    UIView.animate(withDuration: 0.5) {
                        backgroundView.alpha = 0.0
                        contentView.transform = CGAffineTransform(translationX: contentView.frame.size.width + 48, y: 0)
                    } completion: { completed in
                        contentView.removeFromSuperview()
                        backgroundView.removeFromSuperview()
                        completion?()
                    }
                    break
                case .bottomOfView:
                    UIView.animate(withDuration: 0.5) {
                        backgroundView.alpha = 0.0
                        contentView.transform = CGAffineTransform(translationX: contentView.frame.size.width + 48, y: 0)
                    } completion: { completed in
                        contentView.removeFromSuperview()
                        backgroundView.removeFromSuperview()
                        completion?()
                    }
                    break
                }
            }
        } else if let item = popups.last {
            let position = item.position
            let contentView = item.contentView
            let backgroundView = item.backgroundView
            popups.removeLast()
            switch position {
            case .top:
                UIView.animate(withDuration: 0.5) {
                    backgroundView.alpha = 0.0
                    contentView.transform = CGAffineTransform(translationX: 0, y: -(contentView.frame.size.height))
                } completion: { completed in
                    contentView.removeFromSuperview()
                    backgroundView.removeFromSuperview()
                    completion?()
                }
            case .bottom:
                UIView.animate(withDuration: 0.5) {
                    backgroundView.alpha = 0.0
                    contentView.transform = CGAffineTransform(translationX: 0, y: contentView.frame.size.height)
                } completion: { completed in
                    contentView.removeFromSuperview()
                    backgroundView.removeFromSuperview()
                    completion?()
                }

            case .center:
                UIView.animate(withDuration: 0.5) {
                    backgroundView.alpha = 0.0
                    contentView.transform = CGAffineTransform(translationX: 0, y: contentView.frame.size.height + UIScreen.main.bounds.size.height/2)
                } completion: { completed in
                    contentView.removeFromSuperview()
                    backgroundView.removeFromSuperview()
                    completion?()
                }
            case .topOfView:
                UIView.animate(withDuration: 0.5) {
                    backgroundView.alpha = 0.0
                    contentView.transform = CGAffineTransform(translationX: contentView.frame.size.width + 48, y: 0)
                } completion: { completed in
                    contentView.removeFromSuperview()
                    backgroundView.removeFromSuperview()
                    completion?()
                }
                break
            case .bottomOfView:
                UIView.animate(withDuration: 0.5) {
                    backgroundView.alpha = 0.0
                    contentView.transform = CGAffineTransform(translationX: contentView.frame.size.width + 48, y: 0)
                } completion: { completed in
                    contentView.removeFromSuperview()
                    backgroundView.removeFromSuperview()
                    completion?()
                }
                break
            }
        }
    }
    
    func show(view: UIView, position: PopupPosition, absorbTouchBackground: Bool = true, touchBackgroundDismiss: Bool = false) {
        guard let window = SceneManager.shared.visibleNavigation()?.view else {return}
        let backgroundView = UIView()
        backgroundView.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        if absorbTouchBackground {
            backgroundView.isUserInteractionEnabled = true
        } else {
            backgroundView.isUserInteractionEnabled = false
        }
        window.addSubview(backgroundView)
        backgroundView.snp.makeConstraints { maker in
            maker.top.bottom.leading.trailing.equalToSuperview()
        }
        if touchBackgroundDismiss {
            let button = UIButton(type: .custom)
            backgroundView.addSubview(button)
            button.snp.makeConstraints { maker in
                maker.top.bottom.leading.trailing.equalToSuperview()
            }
            button.rx.tap.bind {
                self.dismiss(view)
            }.disposed(by: disposeBag)
        }
        
        window.addSubview(view)
        
        
        // Animate
        backgroundView.alpha = 0.0
        
        switch position {
        case .top:
            view.snp.makeConstraints { maker in
                maker.leading.equalToSuperview().offset(24)
                maker.trailing.equalToSuperview().offset(-24)
                maker.top.equalToSuperview().offset(48)
                maker.height.lessThanOrEqualToSuperview()
            }
            view.transform = CGAffineTransform(translationX: 0, y: -view.frame.size.height)
        case .bottom:
            view.snp.makeConstraints { maker in
                maker.leading.equalToSuperview().offset(0)
                maker.trailing.equalToSuperview().offset(0)
                maker.bottom.equalToSuperview()
                maker.height.lessThanOrEqualToSuperview()
            }
            view.transform = CGAffineTransform(translationX: 0, y: view.frame.size.height)
        case .center:
            view.snp.makeConstraints { maker in
                maker.leading.equalToSuperview().offset(24)
                maker.trailing.equalToSuperview().offset(-24)
                maker.center.equalToSuperview()
                maker.height.lessThanOrEqualToSuperview()
            }
            view.transform = CGAffineTransform(translationX: 0, y: view.frame.size.height + UIScreen.main.bounds.size.height/2)
        case .topOfView(let sourceView, let offset):
            let sourceViewPosition = sourceView.superview?.convert(sourceView.frame.origin, to: nil)
            let offSetView = (window.frame.size.height - (sourceViewPosition?.y ?? 0)) + offset
            view.snp.makeConstraints { maker in
                maker.leading.equalToSuperview().offset(24)
                maker.trailing.equalToSuperview().offset(-24)
                maker.height.lessThanOrEqualToSuperview()
                maker.bottom.equalToSuperview().offset( -offSetView )
            }
            view.transform = CGAffineTransform(translationX: view.frame.size.width + 48, y: 0)
        case .bottomOfView(let sourceView, let offset):
            let sourceViewPosition = sourceView.superview?.convert(sourceView.frame.origin, to: nil)
            let offSetView = ((sourceViewPosition?.y ?? 0) + sourceView.frame.size.height) + offset
            view.snp.makeConstraints { maker in
                maker.leading.equalToSuperview().offset(24)
                maker.trailing.equalToSuperview().offset(-24)
                maker.height.lessThanOrEqualToSuperview()
                maker.top.equalToSuperview().offset(offSetView)
            }
            view.transform = CGAffineTransform(translationX: view.frame.size.width + 48, y: 0)
        }
        self.popups.append((backgroundView, view, position))
        
        UIView.animate(withDuration: 0.35) {
            view.transform = CGAffineTransform.identity
            backgroundView.alpha = 1.0
        } completion: { (completed) in
            
        }
    }
    
    //MARK: show custom view
    func showActionSheet(_ actions: [ActionSheetView.Action]) {
        let actionSheet = ActionSheetView.instatiate()
        actionSheet.addActions(actions.compactMap({ (a) -> ActionSheetView.Action? in
            return ActionSheetView.Action(title: a.title, style: a.style, handler: {
                PopupManager.shared.dismiss(actionSheet, completion: {
                    a.handler?()
                })
            })
        }))
        PopupManager.shared.show(view: actionSheet, position: .bottom)
    }
    
    func showTopPopup(message: String = "", status: Status = .info, timeDisplay: TimeInterval = 3.0) {
        let popup = TopPopupView.instance()
        self.show(view: popup, position: .top, absorbTouchBackground: false)
        popup.setData(message: message, status: status, timeDisplay: timeDisplay)
    }
    
    //    func showAlert(message: String? = nil, attributedMessage: NSAttributedString? = nil, topButton: String? = nil, bottomButton: String? = nil, showingForver: Bool = false, topHandler: (()->Void)? = nil, bottomHandler: (()->Void)? = nil) {
    //        let alert = AlertView.instance()
    //        alert.isShowingForver = showingForver
    //        self.show(view: alert, position: .center)
    //        alert.setData(message: message, attributedMessage: attributedMessage, topButtonTitle: topButton, bottomButtonTitle: bottomButton, topHandler: topHandler, bottomHandler: bottomHandler)
    //    }
    
    
}
