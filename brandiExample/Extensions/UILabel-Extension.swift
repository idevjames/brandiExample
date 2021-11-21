//
//  UILabel-Extension.swift
//  brandiExample
//
//  Created by HooGi on 2021/11/21.
//

import UIKit

extension UILabel {
    func textShadow(color: UIColor, radius: CGFloat, opacity: Float, x: CGFloat, y: CGFloat) {
        self.layer.shadowColor = color.cgColor
        self.layer.shadowRadius = radius
        self.layer.shadowOpacity = opacity
        self.layer.shadowOffset = CGSize(width: x, height: y)
        self.layer.masksToBounds = false
    }
}
