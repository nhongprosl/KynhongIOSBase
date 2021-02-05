//
//  ViewExtension.swift
//  KynhongIOSBase
//
//  Created by Kynhong on 2/5/21.
//

import Foundation
import UIKit

extension UIView {
    func showActivityIndicator() {
        if #available(iOS 13.0, *) {
            let activityIndicator = UIActivityIndicatorView(style: .large)
//            activityIndicator.color = DataManager.shared.styleConfigured == .light ? Color.P4.value : Color.P1.value
            activityIndicator.hidesWhenStopped = true
            activityIndicator.tag = 12421
            self.addSubview(activityIndicator)
            activityIndicator.snp.makeConstraints { maker in
                maker.centerX.centerY.equalToSuperview()
            }
            activityIndicator.startAnimating()
        } else {
            let activityIndicator = UIActivityIndicatorView(style: .whiteLarge)
//            activityIndicator.color = DataManager.shared.styleConfigured == .light ? Color.P4.value : Color.P1.value
            activityIndicator.hidesWhenStopped = true
            activityIndicator.tag = 12421
            self.addSubview(activityIndicator)
            activityIndicator.snp.makeConstraints { maker in
                maker.centerX.centerY.equalToSuperview()
            }
            activityIndicator.startAnimating()
        }
        
    }
    
    func hideActivityIndicator() {
        let activityLoading = self.subviews.first { (subview) -> Bool in
            return (subview.isKind(of: UIActivityIndicatorView.self) && subview.tag == 12421)
        } as? UIActivityIndicatorView
        activityLoading?.stopAnimating()
        activityLoading?.removeFromSuperview()
    }
    
    func removeDash() {
        self.layer.sublayers?.map { $0.name == "dashBorderLayer" ? $0 : nil }.forEach({ layer in
            layer?.removeFromSuperlayer()
        })
    }
    func addDashedBorder(length: Float, space: Float, color: UIColor) {
        //Create a CAShapeLayer
        self.layer.sublayers?.map { $0.name == "dashBorderLayer" ? $0 : nil }.forEach({ layer in
            layer?.removeFromSuperlayer()
        })
        let shapeLayer = CAShapeLayer()
        shapeLayer.strokeColor = color.cgColor
        shapeLayer.lineWidth = 1
        shapeLayer.name = "dashBorderLayer"
        // passing an array with the values [2,3] sets a dash pattern that alternates between a 2-user-space-unit-long painted segment and a 3-user-space-unit-long unpainted segment
        shapeLayer.lineDashPattern = [NSNumber(value: length), NSNumber(value: space)]
        
        let path = CGMutablePath()
        path.addLines(between: [CGPoint(x: 1, y: 1),
                                CGPoint(x: self.frame.width, y: 0)])
        shapeLayer.path = path
        layer.addSublayer(shapeLayer)
    }
    
    func addDashBorder(cornerRadius: CGFloat, color: UIColor, width: CGFloat, height: CGFloat) {
        self.layer.sublayers?.map { $0.name == "dashBorderLayer" ? $0 : nil }.forEach({ layer in
            layer?.removeFromSuperlayer()
        })
        let yourViewBorder = CAShapeLayer()
        yourViewBorder.name = "dashBorderLayer"
        yourViewBorder.strokeColor = color.cgColor
        yourViewBorder.lineDashPattern = [2, 2]
        yourViewBorder.frame = CGRect(x: 0, y: 0, width: width, height: height)
        yourViewBorder.fillColor = nil
        yourViewBorder.path = UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: width, height: height), byRoundingCorners: .allCorners, cornerRadii: CGSize(width: cornerRadius, height: cornerRadius)).cgPath
        self.layer.addSublayer(yourViewBorder)
    }
    
    func addVerticalDashedBorder(length: Float, space: Float, color: UIColor, height: CGFloat = 0) {
        //Create a CAShapeLayer
        self.layer.sublayers?.map { $0.name == "dashBorderLayer" ? $0 : nil }.forEach({ layer in
            layer?.removeFromSuperlayer()
        })
        let shapeLayer = CAShapeLayer()
        shapeLayer.strokeColor = color.cgColor
        shapeLayer.lineWidth = 1
        shapeLayer.name = "dashBorderLayer"
        // passing an array with the values [2,3] sets a dash pattern that alternates between a 2-user-space-unit-long painted segment and a 3-user-space-unit-long unpainted segment
        shapeLayer.lineDashPattern = [NSNumber(value: length), NSNumber(value: space)]
        
        let path = CGMutablePath()
        path.addLines(between: [CGPoint(x: 1, y: 1),
                                CGPoint(x: 0, y: height > 0 ? height : self.frame.height)])
        shapeLayer.path = path
        layer.addSublayer(shapeLayer)
    }
    
    func textField() -> UITextField? {
        if self is UITextField {
            return self as? UITextField
        }
        for subView in self.subviews {
            if let textField = subView.textField() {
                return textField
            }
        }
        return nil
    }
    
    func textView() -> UITextView? {
        if self is UITextView {
            return self as? UITextView
        }
        for subView in self.subviews {
            if let textField = subView.textView() {
                return textField
            }
        }
        return nil
    }
    
    func getSnapshot() -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(CGSize(width: self.frame.size.width * 2, height: self.frame.size.height * 2), false, 1.0)
        self.drawHierarchy(in: CGRect(x: 0, y: 0, width: self.frame.size.width * 2, height: self.frame.size.height * 2), afterScreenUpdates: true)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
    
    func removeSubviews() {
        self.subviews.forEach { subView in
            subView.removeFromSuperview()
        }
    }
}
