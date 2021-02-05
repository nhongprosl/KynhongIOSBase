//
//  TableViewExtension.swift
//  KynhongIOSBase
//
//  Created by Kynhong on 2/5/21.
//

import Foundation
import UIKit

extension UITableView {
    func dequeueReusableCell<T: UITableViewCell>(with classType: T.Type) -> T {
        return self.dequeueReusableCell(withIdentifier: String(describing: classType)) as! T
    }
    
    func registerNib<T: UITableViewCell>(with classType: T.Type, in bundle: Bundle? = nil) {
        self.register(UINib(nibName: String(describing: classType), bundle: bundle) , forCellReuseIdentifier: String(describing: classType))
    }

    
    func beginEdit() {
        for i in 0..<self.numberOfSections {
            for j in 0..<self.numberOfRows(inSection: i) {
                if let cell = self.cellForRow(at: IndexPath(row: j, section: i)) {
                    if let textField = cell.textField() {
                        textField.becomeFirstResponder()
                        return
                    } else if let textView = cell.textView() {
                        textView.becomeFirstResponder()
                        return
                    }
                }
            }
        }
    }

}

