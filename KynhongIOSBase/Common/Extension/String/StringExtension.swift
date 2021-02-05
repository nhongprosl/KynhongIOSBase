//
//  StringExtension.swift
//  KynhongIOSBase
//
//  Created by Kynhong on 2/4/21.
//

import Foundation
import UIKit

extension String {
    func isEmail() -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: self)
    }
    
    func localized(comment: String = "") -> String {
        return NSLocalizedString(self, comment: comment)
    }
    
    var trimmed: String {
        return self.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
    }
    
    func date(with format: String = "dd/MM/yyyy") -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.date(from: self)
    }
    
    func toImage() -> UIImage? {
        if let url = URL(string: self) {
            if let data = try? Data(contentsOf: url), let image = UIImage(data: data) {
                return image
            }
        }
        return nil
    }
    
    func isOnlyDecimal() -> Bool {
        return CharacterSet(charactersIn: "0123456789").isSuperset(of: CharacterSet(charactersIn: self))
    }
    
    var stripped: String {
        let okayChars = Set("abcdefghijklmnopqrstuvwxyz ABCDEFGHIJKLKMNOPQRSTUVWXYZ")
        return self.filter {okayChars.contains($0) }
    }
    
    func isDefaultAvatar() -> Bool {
        return self.contains(defaultAvatar)
    }
}
