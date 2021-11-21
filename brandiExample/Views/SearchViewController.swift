//
//  SearchViewController.swift
//  brandiExample
//
//  Created by HooGi on 2021/11/17.
//

import UIKit
import RxSwift
import RxCocoa
import SwiftUI

class SearchViewController: ViewController {
    
    // MARK: - UI Components
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var emptyLabel: UILabel!
    
    // MARK: - Rx Properties
    private let disposeBag = DisposeBag()
    private let searchText = PublishRelay<String>()
    private let loadMore = BehaviorRelay<Bool>(value: false)
    private lazy var viewModel = SearchViewModel(navigator: .init(self.navigationController))
    
    // MARK: - Properties
    private var searchBarTimer: Timer?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        bindUI()
        bindViewModel()
        setProperties()
        setupUI()
    }

    // MARK: - CONFIGURATION
    private func setupUI() {
        searchBar.rx.setDelegate(self).disposed(by: disposeBag)
        collectionView.rx.setDelegate(self).disposed(by: disposeBag)
        
        /// CollectionView layout
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        
        collectionView.register(SearchCell.self, forCellWithReuseIdentifier: SearchCell.identifier)
        collectionView.collectionViewLayout = layout
    }
    
    private func setProperties() {
        collectionView.keyboardDismissMode = .onDrag
        navigationItem.title = "Search Images"
        emptyLabel.isHidden = true
    }
    
    private func bindUI() {
        /// 초기 진입시 키보드 노출
        rx.sentMessage(#selector(viewDidAppear(_:))).take(1)
            .subscribe(onNext: { [weak self] _ in
                guard let self = self else { return }
                
                self.searchBar.becomeFirstResponder()
            })
            .disposed(by: disposeBag)
        
        /// 검색어 입력 후 1초 경과
        searchText.asDriverComplete()
            .drive(onNext: { [weak self] (text) in
                guard let self = self else { return }
                self.searchBar.resignFirstResponder()
                self.collectionView.setContentOffset(.zero, animated: false)
                self.collectionView.layoutIfNeeded()
                self.showLoading()
            })
            .disposed(by: disposeBag)
        
        /// Loadmore
        collectionView.rx.contentOffset.asDriver()
            .map { _ in self.requestLoadMore() }
            .distinctUntilChanged()
            .drive(loadMore)
            .disposed(by: disposeBag)
    }
    
    private func bindViewModel() {
        let input = SearchViewModel.Input(searchText: searchText.asDriverComplete(),
                                          loadMore: loadMore.asDriver(),
                                          imageSelected: collectionView.rx.modelSelected(ImageModel.self))

        let output = viewModel.transform(input: input)

        output.images
            .do(onNext: { [weak self] (images) in
                guard let self = self else{ return }
                self.hideLoading()
                self.emptyLabel.isHidden = (images.count > 0) ? true : false
            })
            .bind(to: collectionView.rx.items(cellIdentifier: SearchCell.identifier, cellType: SearchCell.self)) { (item, model, cell) in
                cell.configure(model)
            }
            .disposed(by: disposeBag)
    }
    
    // MARK: - Private Methods
    private func requestLoadMore() -> Bool {
        guard collectionView.contentSize.height > collectionView.frame.height else { return false }

        let contentHeight = collectionView.contentSize.height - collectionView.frame.height
        print(collectionView.contentOffset.y >= contentHeight)
        return collectionView.contentOffset.y >= contentHeight
    }
}


// MARK: - SearchViewController Extensions

/// `SearchBar Deleagte`
extension SearchViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            return
        }
        /// 1초동안 검색어가 변경되지 않으면 해당 검색어로 검색
        searchBarTimer?.invalidate()
        searchBarTimer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: false, block: { [weak self] _ in
            self?.searchText.accept(searchText)
        })
    }
}

/// `CollectioinView Layout Delegate`
extension SearchViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth = UIScreen.main.bounds.width / 3
        return CGSize(width: cellWidth, height: cellWidth)
    }
}
