//
//  UIImageView-Extension.swift
//  brandiExample
//
//  Created by HooGi on 2021/11/19.
//

import Foundation
import UIKit
import Kingfisher

extension UIImageView {
    func loadImage(urlString: String?) {
        if let urlString = urlString, let url = URL(string: urlString) {
            self.kf.setImage(with: url)
        }
    }
}
