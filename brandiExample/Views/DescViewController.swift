//
//  DescViewController.swift
//  brandiExample
//
//  Created by HooGi on 2021/11/19.
//

import UIKit
import RxSwift
import RxCocoa
import Kingfisher

class DescViewController: ViewController {

    // MARK: - UI Components
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var imageViewHeight: NSLayoutConstraint!
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var sourceView: UIView!
    @IBOutlet weak var sourceLabel: UILabel!
    @IBOutlet weak var createDateView: UIView!
    @IBOutlet weak var createDatelabel: UILabel!
    
    // MARK: - Properties
    var viewModel: DescViewModel!
    private let disposebag = DisposeBag()
    
    // MARK: - Initializes
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        showLoading()
        
        bindViewModel()
        setProperties()
        setupUI()
    }
    
    private func setupUI() {
        sourceView.isHidden = true
        createDateView.isHidden = true
    }
    
    private func setProperties() {
        createDatelabel.textColor = .white
        sourceLabel.textColor = .white
        createDatelabel.textShadow(color: .black, radius: 1.0, opacity: 0.7, x: 1, y: 1)
        sourceLabel.textShadow(color: .black, radius: 1.0, opacity: 0.7, x: 1, y: 1)
    }
    
    private func bindViewModel() {
        let viewDidAppear = rx.sentMessage(#selector(viewDidAppear(_:))).take(1).mapToVoid().asDriverComplete()
        let input = DescViewModel.Input(trigger: viewDidAppear)
        let output = viewModel.transform(input: input)
        
        output.imageURL
            .drive(onNext: { [weak self] (url) in
                guard let self = self else { return }
                
                self.imageView.kf.setImage(with: url)
                self.hideLoading()
            })
            .disposed(by: disposebag)
        
        output.source
            .drive(onNext: { [weak self] (source) in
                guard let self = self else{ return }
                
                self.sourceView.isHidden = false
                self.sourceLabel.text = "출처 : \(source)"
                
            })
            .disposed(by: disposebag)
        
        output.createDate
            .drive(onNext: { [weak self] (date) in
                guard let self = self else{ return }
                
                self.createDateView.isHidden = false
                self.createDatelabel.text = "작성일자 : \(date.toString())"
            })
            .disposed(by: disposebag)
        
        output.imageSize
            .drive(onNext: { [weak self] (size) in
                guard let self = self else{ return }
                
                self.imageViewHeight.constant = size.resizeToScreen().height
            })
            .disposed(by: disposebag)
    }
}
