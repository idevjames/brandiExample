//
//  UIViewController.swift
//  brandiExample
//
//  Created by HooGi on 2021/11/18.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: - Common UI Components
    private let activity: UIActivityIndicatorView = {
        let activity = UIActivityIndicatorView()
        activity.translatesAutoresizingMaskIntoConstraints = false
        activity.style = .large
        activity.backgroundColor = .black.withAlphaComponent(0.2)
        activity.startAnimating()
        activity.alpha = 0
        
        return activity
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    // MARK: - Public Methods
    public func showLoading() {
        view.addSubview(activity)
        
        var topMargin = 0.0
        
        /// 네비게이션이 있는 경우 네비게이션이 동작할 수 있도록 마진 설정
        if let parent = self.parent, let navigation = parent as? UINavigationController {
            topMargin = navigation.navigationBar.frame.maxY
        }
        
        NSLayoutConstraint.activate([
            activity.topAnchor.constraint(equalTo: view.topAnchor, constant: topMargin),
            activity.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            activity.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            activity.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        activity.alpha = 1
    }
    
    public func hideLoading() {
        activity.alpha = 0
        activity.removeFromSuperview()
    }
}
