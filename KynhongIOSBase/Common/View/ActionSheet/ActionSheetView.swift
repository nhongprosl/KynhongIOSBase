//
//  ActionSheetView.swift
//  KynhongIOSBase
//
//  Created by Kynhong on 25/02/2021.
//

import UIKit
import IBAnimatable
import RxSwift
import SnapKit

class ActionSheetView: UIView {

    enum Style {
        case `default`
        case cancel
    }
    
    struct Action {
        let title: String
        let style: Style
        var handler: (() -> Void)?
    }

    @IBOutlet weak var stackView: UIStackView!
    
    let disposeBag = DisposeBag()
    var actions: [Action] = []
    
    class func instatiate() -> ActionSheetView {
        let v = Bundle.main.loadNibNamed("ActionSheetView", owner: nil, options: nil)?.first as! ActionSheetView
        return v
    }
    
    func addActions(_ actions: [Action]) {
        actions.forEach { [weak self] (action) in
            guard let self = self else { return }
            let btn = AnimatableButton()
            btn.snp.makeConstraints { (maker) in
                maker.height.equalTo(48)
            }
            btn.cornerRadius = 24
            btn.fillColor = #colorLiteral(red: 0.1019607857, green: 0.2784313858, blue: 0.400000006, alpha: 1)
            btn.setTitleColor(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), for: .normal)
            btn.setTitle(action.title, for: .normal)
            btn.rx.controlEvent(.touchUpInside).bind(onNext: {
                action.handler?()
            }).disposed(by: self.disposeBag)
            self.stackView.addArrangedSubview(btn)
        }
    }
    
}
