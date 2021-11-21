//
//  NavigationController.swift
//  brandiExample
//
//  Created by HooGi on 2021/11/18.
//

import UIKit

class NavigationController: UINavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationBar.prefersLargeTitles = true
        navigationBar.tintColor = .systemBackground
        
        navigationBar.largeTitleTextAttributes = [
            .foregroundColor : UIColor.systemBackground,
            .font : UIFont.systemFont(ofSize: 23, weight: .semibold)
        ]
        
        navigationBar.titleTextAttributes = [
            .foregroundColor : UIColor.systemBackground,
            .font : UIFont.systemFont(ofSize: 17, weight: .semibold)
        ]
    }
}
