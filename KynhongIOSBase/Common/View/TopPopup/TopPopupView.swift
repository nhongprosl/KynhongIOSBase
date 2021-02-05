//
//  TopPopupView.swift
//  KynhongIOSBase
//
//  Created by Kynhong on 2/4/21.
//

import UIKit
import IBAnimatable
import RxSwift
import RxCocoa

class TopPopupView: UIView {
    let disposeBag = DisposeBag()
    @IBOutlet weak var backgroundView: AnimatableView!
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    var style: Style = .light
    var message: String = ""
    var status: Status = .warning
    var timeDisplay: TimeInterval = 3.0
    
    fileprivate var dismissWork: DispatchWorkItem?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setupStyle(.light)
//        SceneManager.shared.styleObservable.subscribe(onNext: {[weak self] value in
//            guard let self = self else {return}
//            self.styleChanged(value)
//        }).disposed(by: disposeBag)
        let panGesture = UIPanGestureRecognizer()
        self.addGestureRecognizer(panGesture)
        panGesture.rx.event.bind {[weak self] gesture in
            self?.dismissWork?.cancel()
            self?.dismiss()
        }.disposed(by: disposeBag)
    }
    
    class func instance() -> TopPopupView {
        return Bundle.main.loadView(with: TopPopupView.self)
    }

    func setData(message: String, status: Status = .warning, timeDisplay: TimeInterval = 3.0) {
        self.message = message
        self.status = status
        self.timeDisplay = timeDisplay
        self.setupContent()
        self.dismissWork = DispatchWorkItem { [weak self] in
            self?.dismiss()
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + timeDisplay, execute: self.dismissWork!)
    }
    
    fileprivate func setupContent() {
        self.titleLabel.text = message
        self.iconImageView.image = self.status.icon(.light)
    }
    
    func setupStyle(_ style: Style) {
        self.style = style
        self.iconImageView.image = self.status.icon(style)
        switch style {
        case .light:
//            self.backgroundView.backgroundColor = UIColor.white
            self.titleLabel.textColor = UIColor.black.withAlphaComponent(0.87)
        case .dark:
//            self.backgroundView.backgroundColor = Color.P3.value
            self.titleLabel.textColor = UIColor.white
        }
    }
    
    func styleChanged(_ style: Style) {
        self.setupStyle(style)
        self.setupContent()
    }
    
    @objc func dismiss() {
        PopupManager.shared.dismiss(self)
    }
}
