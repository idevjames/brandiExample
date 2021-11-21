//
//  String-Extension.swift
//  brandiExample
//
//  Created by HooGi on 2021/11/19.
//

import Foundation

extension String {
    func toDate() -> Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSz"
        formatter.locale = Locale(identifier: "ko_KR")
        let date = formatter.date(from: self)
        return date ?? nil
    }
}
