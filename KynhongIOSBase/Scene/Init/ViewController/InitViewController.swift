//
//  InitViewController.swift
//  KynhongIOSBase
//
//  Created by Kynhong on 1/27/21.
//

import Foundation

class InitViewController: ViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    @IBAction func buttonClick(_ sender: Any) {
//        PopupManager.shared.showTopPopup(message: "hello", status: .info, timeDisplay: 3.0)
        
        let arr = [
            ActionSheetView.Action(title: "button1", style: .default, handler: {}),
            ActionSheetView.Action(title: "button2", style: .default, handler: {})
        ]
        
        PopupManager.shared.showActionSheet(arr)
    }
    
}
