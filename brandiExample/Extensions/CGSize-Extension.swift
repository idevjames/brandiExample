//
//  CGSize-Extension.swift
//  brandiExample
//
//  Created by HooGi on 2021/11/21.
//

import UIKit

extension CGSize {
    func resizeToScreen() -> CGSize {
        let screen = UIScreen.main.bounds
        let rate = screen.width / self.width
        
        return CGSize(width: screen.width, height: self.height * rate)
//        let screen = UIScreen.main.bounds
//        let multiplier = screen.width / self.width
//
//        return CGSize(width: screen.width, height: screen.height / multiplier)
//        let rate: CGFloat = self.width / self.height
//        let screen = UIScreen.main.bounds
//
//        return CGSize(width: screen.width, height: screen.height / rate)
    }
}
