//
//  TabbarItem.swift
//  KynhongIOSBase
//
//  Created by Kynhong on 03/03/2021.
//

import Foundation
import UIKit
import IBAnimatable

protocol TabbarItemDelegate: class {
    func didSelectItem(_ item: TabbarItem)
}
class TabbarItem {
    let index: Int
    let normalImage: UIImage?
    let selectedImage: UIImage?
    var isSelected: Bool = false {
        didSet {
            self.configButton()
        }
    }
    weak var delegate: TabbarItemDelegate?
    
    init(index: Int, normalImage: UIImage?, selectedImage: UIImage?) {
        self.index = index
        self.normalImage = normalImage
        self.selectedImage = selectedImage
        
        self.setup()
    }
    
    func getItemButton() -> UIButton {
        return itemButton
    }
    
    private var itemButton: UIButton!
    
    private func setup() {
        self.itemButton = UIButton()
        self.itemButton.setImage(normalImage, for: .normal)
        if let selectedImage = self.selectedImage {
            self.itemButton.setImage(selectedImage, for: .selected)
            self.itemButton.setImage(selectedImage, for: .highlighted)
        } else {
            self.itemButton.setImage(normalImage, for: .selected)
            self.itemButton.setImage(normalImage, for: .highlighted)
        }
        self.itemButton.addTarget(self, action: #selector(itemButtonClicked(_:)), for: .touchUpInside)
        self.configButton()
    }
    
    private func configButton() {
        self.itemButton.isSelected = isSelected
        if isSelected {
            self.itemButton.setImage(normalImage, for: .highlighted)
        } else {
            self.itemButton.setImage(selectedImage, for: .highlighted)
        }
    }
    
    @IBAction func itemButtonClicked(_ sender: UIButton) {
        self.delegate?.didSelectItem(self)
    }
}
