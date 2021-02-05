//
//  DateExtensiom.swift
//  KynhongIOSBase
//
//  Created by Kynhong on 2/5/21.
//

import Foundation
import UIKit

extension Date {
    func string(format: String = "dd/MM/yyyy") -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }
}
