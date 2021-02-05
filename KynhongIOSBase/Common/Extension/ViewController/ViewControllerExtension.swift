//
//  ViewControllerExtension.swift
//  KynhongIOSBase
//
//  Created by Kynhong on 2/4/21.
//

import Foundation
import UIKit

extension UIViewController {
    
    func share(items: [Any]) {
        let activityViewController = UIActivityViewController(activityItems: items, applicationActivities: nil)
        self.present(activityViewController, animated: true, completion: nil)
    }
    
    func showActionSheet(title: String?, message: String?, actions: [String] = [], cancel: String?, handle: @escaping (_ index: Int)->Void) {
        let actionSheet = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
        for i in 0..<actions.count {
            let action = actions[i]
            actionSheet.addAction(UIAlertAction(title: action, style: .default, handler: { _ in
                handle(i)
            }))
        }
        if cancel != nil {
            actionSheet.addAction(UIAlertAction(title: cancel, style: .destructive, handler: nil))
        }
        self.present(actionSheet, animated: true, completion: nil)
    }
    
    func safeAreaHeight() -> CGFloat {
        let keyWindow = UIApplication.shared.keyWindow
        let top = keyWindow?.safeAreaInsets.top ?? 0
        let bottom = keyWindow?.safeAreaInsets.bottom ?? 0
        return UIScreen.main.bounds.size.height - top - bottom
    }
    
    func safeAreaFrame() -> CGRect {
        return CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: self.safeAreaHeight())
    }
    
    func tableViewFrame(_ haveNavigationBar: Bool = false) -> CGRect {
        return CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: self.safeAreaHeight() - (haveNavigationBar ? 40 : 0))
    }
    
    func getSafeAreaInset() -> UIEdgeInsets {
        return self.view.safeAreaInsets
    }
}
