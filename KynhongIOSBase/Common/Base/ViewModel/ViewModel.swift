//
//  ViewModel.swift
//  KynhongIOSBase
//
//  Created by Kynhong on 1/27/21.
//

import Foundation
import RxSwift

class ViewModel: NSObject {
    let disposeBag = DisposeBag()
    let initialData: Any?
    let isLoading: BehaviorSubject<Bool>
    var isLocking: Bool = false
//    var backendConnector: BackendConnector?
    
    fileprivate var tableView: UITableView?
    
    required init(_ initialData: Any? = nil) {
        self.initialData = initialData
        self.isLoading = BehaviorSubject(value: false)
    }
    
    func bind(_ tableView: UITableView?) {
        self.tableView = tableView
    }
    
//    func connector<T: BackendConnector>(_ type: T.Type) -> T {
//        return self.backendConnector as! T
//    }
}
