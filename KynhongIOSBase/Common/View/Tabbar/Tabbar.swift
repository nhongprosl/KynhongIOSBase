//
//  Tabbar.swift
//  KynhongIOSBase
//
//  Created by Kynhong on 03/03/2021.
//

import UIKit
import SnapKit

protocol TabbarDelegate: class {
    func didSelectItem(at index: Int)
}

@IBDesignable
class Tabbar: UIView {
    weak var homeItemView: UIView?
    weak var home2ItemView: UIView?
    weak var home3ItemView: UIView?
    weak var home4ItemView: UIView?
    
    @IBInspectable
    var selectedIndex: Int = 0 {
        didSet {
            self.configSelected()
        }
    }
    
    weak var delegate: TabbarDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.setupUI()
    }
    
    // MARK: - Private variables
    var tabbarItems: [TabbarItem] = []
    private var lastSelectedIndex: Int = 0
    
    // MARK: - Private functions
    private func setupUI() {
        let homeItem = TabbarItem(index: 0, normalImage: UIImage(named: "TabbarItem"), selectedImage: UIImage(named: "TabbarItemSelected"))
        homeItem.delegate = self
        let home2Item = TabbarItem(index: 1, normalImage: UIImage(named: "TabbarItem"), selectedImage: UIImage(named: "TabbarItemSelected"))
        home2Item.delegate = self
        let home3Item = TabbarItem(index: 2, normalImage: UIImage(named: "TabbarItem"), selectedImage: UIImage(named: "TabbarItemSelected"))
        home3Item.delegate = self
        let home4Item = TabbarItem(index: 3, normalImage: UIImage(named: "TabbarItem"), selectedImage: UIImage(named: "TabbarItemSelected"))
        home4Item.delegate = self
        tabbarItems.append(contentsOf: [homeItem, home2Item, home3Item, home4Item])
        
        let backgroundView = UIView()
        backgroundView.backgroundColor = UIColor.white
        self.addSubview(backgroundView)
        backgroundView.snp.makeConstraints { maker in
            maker.leading.trailing.bottom.top.equalToSuperview()
        }
        let homeButton = homeItem.getItemButton()
        let home2Button = home2Item.getItemButton()
        let home3Button = home3Item.getItemButton()
        let home4Button = home4Item.getItemButton()
        backgroundView.addSubview(homeButton)
        backgroundView.addSubview(home2Button)
        backgroundView.addSubview(home3Button)
        backgroundView.addSubview(home4Button)
        homeButton.snp.makeConstraints { maker in
            maker.leading.equalToSuperview().offset(16)
            maker.top.equalToSuperview().offset(8)
            maker.bottom.equalToSuperview().offset(-8)
            maker.width.equalTo((self.frame.width - 80)/4)
        }
        self.homeItemView = homeButton
        home2Button.snp.makeConstraints { maker in
            maker.leading.equalTo(homeButton.snp.trailing).offset(16)
            maker.top.equalToSuperview().offset(8)
            maker.bottom.equalToSuperview().offset(-8)
            maker.width.equalTo((self.frame.width - 80)/4)
        }
        self.home2ItemView = homeButton
        home3Button.snp.makeConstraints { maker in
            maker.leading.equalTo(home2Button.snp.trailing).offset(16)
            maker.top.equalToSuperview().offset(8)
            maker.bottom.equalToSuperview().offset(-8)
            maker.width.equalTo((self.frame.width - 80)/4)
        }
        self.home3ItemView = homeButton
        home4Button.snp.makeConstraints { maker in
            maker.leading.equalTo(home3Button.snp.trailing).offset(16)
            maker.trailing.equalToSuperview().offset(-16)
            maker.top.equalToSuperview().offset(8)
            maker.bottom.equalToSuperview().offset(-8)
        }
        self.home4ItemView = homeButton
        self.configSelected()
    }
    
    private func configSelected() {
        for item in self.tabbarItems {
            item.isSelected = item.index == self.selectedIndex
        }
        self.lastSelectedIndex = self.selectedIndex
    }
    
}

extension Tabbar: TabbarItemDelegate {
    func didSelectItem(_ item: TabbarItem) {
        self.delegate?.didSelectItem(at: item.index)
        self.selectedIndex = item.index
    }
}
