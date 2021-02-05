//
//  CollectionViewExtension.swift
//  KynhongIOSBase
//
//  Created by Kynhong on 2/5/21.
//

import Foundation
import UIKit

extension UICollectionView {
    func dequeueReusableCell<T: UICollectionViewCell>(with classType: T.Type, for indexPath: IndexPath) -> T {
        return self.dequeueReusableCell(withReuseIdentifier: String(describing: classType), for: indexPath) as! T
    }
    
    func registerNib<T: UICollectionViewCell>(with classType: T.Type, in bundle: Bundle? = nil) {
        self.register(UINib(nibName: String(describing: classType), bundle: bundle), forCellWithReuseIdentifier: String(describing: classType))
    }
}

