//
//  TableProtocol.swift
//  KynhongIOSBase
//
//  Created by Kynhong on 2/2/21.
//

import Foundation
import UIKit

protocol CellDataProtocol {
    func setData(_ data: Any?)
}

typealias TableItem = (cellType: UITableViewCell.Type, data: Any?)
typealias TableItems = [TableItem]
typealias TableSection = (header: UIView?, headerHeight: CGFloat, items: TableItems)
typealias TableSections = [TableSection]

typealias CollectionItem = (cellType: UICollectionViewCell.Type, data: Any?)
typealias CollectionItems = [CollectionItem]
