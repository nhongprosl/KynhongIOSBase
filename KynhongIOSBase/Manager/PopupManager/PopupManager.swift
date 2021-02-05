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
    
//    func showAlert(message: String? = nil, attributedMessage: NSAttributedString? = nil, topButton: String? = nil, bottomButton: String? = nil, showingForver: Bool = false, topHandler: (()->Void)? = nil, bottomHandler: (()->Void)? = nil) {
//        let alert = AlertView.instance()
//        alert.isShowingForver = showingForver
//        self.show(view: alert, position: .center)
//        alert.setData(message: message, attributedMessage: attributedMessage, topButtonTitle: topButton, bottomButtonTitle: bottomButton, topHandler: topHandler, bottomHandler: bottomHandler)
//    }
//        
//    func showTopPopup(message: String = "", status: Status = .info, timeDisplay: TimeInterval = 3.0) {
//        let popup = TopPopupView.instance()
//        self.show(view: popup, position: .top, absorbTouchBackground: false)
//        popup.setData(message: message, status: status, timeDisplay: timeDisplay)
//    }
    
    func dismiss(_ view: UIView? = nil) {
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
                    }
                case .bottom:
                    UIView.animate(withDuration: 0.5) {
                        backgroundView.alpha = 0.0
                        contentView.transform = CGAffineTransform(translationX: 0, y: contentView.frame.size.height)
                    } completion: { completed in
                        contentView.removeFromSuperview()
                        backgroundView.removeFromSuperview()
                    }

                case .center:
                    UIView.animate(withDuration: 0.5) {
                        backgroundView.alpha = 0.0
                        contentView.transform = CGAffineTransform(translationX: 0, y: contentView.frame.size.height + UIScreen.main.bounds.size.height/2)
                    } completion: { completed in
                        contentView.removeFromSuperview()
                        backgroundView.removeFromSuperview()
                    }

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
                }
            case .bottom:
                UIView.animate(withDuration: 0.5) {
                    backgroundView.alpha = 0.0
                    contentView.transform = CGAffineTransform(translationX: 0, y: contentView.frame.size.height)
                } completion: { completed in
                    contentView.removeFromSuperview()
                    backgroundView.removeFromSuperview()
                }

            case .center:
                UIView.animate(withDuration: 0.5) {
                    backgroundView.alpha = 0.0
                    contentView.transform = CGAffineTransform(translationX: 0, y: contentView.frame.size.height + UIScreen.main.bounds.size.height/2)
                } completion: { completed in
                    contentView.removeFromSuperview()
                    backgroundView.removeFromSuperview()
                }

            }
        }
    }
    
    fileprivate func show(view: UIView, position: PopupPosition, absorbTouchBackground: Bool = true) {
        guard let window = UIApplication.shared.windows.last else {return}
        let backgroundView = UIView()
        backgroundView.backgroundColor = UIColor.black.withAlphaComponent(0.25)
        if absorbTouchBackground {
            backgroundView.isUserInteractionEnabled = true
        } else {
            backgroundView.isUserInteractionEnabled = false
        }
        window.addSubview(backgroundView)
        backgroundView.snp.makeConstraints { maker in
            maker.top.bottom.leading.trailing.equalToSuperview()
        }
        
        backgroundView.addSubview(view)
        
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
                maker.leading.equalToSuperview().offset(24)
                maker.trailing.equalToSuperview().offset(-24)
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
        }
        self.popups.append((backgroundView, view, position))
        
        UIView.animate(withDuration: 0.5) {
            view.transform = CGAffineTransform.identity
            backgroundView.alpha = 1.0
        } completion: { (completed) in
            
        }
    }
    
    
}
