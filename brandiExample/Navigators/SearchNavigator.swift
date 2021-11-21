//
//  SearchNavigator.swift
//  brandiExample
//
//  Created by HooGi on 2021/11/21.
//

import UIKit

final class SearchNavigator {
    // MARK: - Properties
    private let mainBoard = UIStoryboard.init(name: "Main", bundle: Bundle.main)
    private let navigationController: UINavigationController?
    
    init(_ navigationController: UINavigationController?) {
        self.navigationController = navigationController
    }
    
    // MARK: - Internal Method
    
    func showDescription(model: ImageModel) {
        let descVC = mainBoard.instantiateViewController(withIdentifier: "DescViewController") as! DescViewController
        descVC.viewModel = DescViewModel(model: model)
        navigationController?.pushViewController(descVC, animated: true)
    }
    
}
