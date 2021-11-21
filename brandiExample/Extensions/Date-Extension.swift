//
//  Date-Extension.swift
//  brandiExample
//
//  Created by HooGi on 2021/11/21.
//

import Foundation

extension Date {
    func toString() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        return formatter.string(from: self)
    }
}
