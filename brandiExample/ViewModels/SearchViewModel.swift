//
//  SearchViewModel.swift
//  brandiExample
//
//  Created by HooGi on 2021/11/19.
//

import Foundation
import RxSwift
import RxCocoa
import Alamofire

final class SearchViewModel {

    // MARK: - Properties
    private let navigator: SearchNavigator
    private let disposeBag = DisposeBag()
    private let apiManager = KakaoAPIManager.shared
    private var images = BehaviorRelay<[ImageModel]>(value: [])
    private var searchText = String()
    private var page: Int = 1
    private var isEndPage: Bool = true

    init(navigator: SearchNavigator) {
        self.navigator = navigator
    }

    struct Input {
        let searchText: Driver<String>
        let loadMore: Driver<Bool>
        let imageSelected: ControlEvent<ImageModel>
    }

    struct Output {
        let images: Observable<[ImageModel]>
    }

    // MARK: - Methods
    func transform(input: Input) -> Output {
        /// '검색어' 기반 이미지 요청
        input.searchText
            .drive(onNext: { [weak self] (searchText) in
                guard let self = self else { return }

                self.requestImages(searchText: searchText)
            })
            .disposed(by: disposeBag)

        /// LoadMore
        input.loadMore
            .drive(onNext: { [weak self] _ in
                guard let self = self else { return }

                self.requestLoadMoreImages()
            })
            .disposed(by: disposeBag)

        /// 이미지 선택
        input.imageSelected
            .bind { [weak self] (model) in
                guard let self = self else { return }

                self.navigator.showDescription(model: model)
            }
            .disposed(by: disposeBag)

        return Output(images: images.asObservable())
    }


    // MARK: - Private Methods
    private func requestImages(searchText: String) {
        self.searchText = searchText
        self.page = 1

        apiManager.requestAPI(search: searchText, page: page) { [weak self] error, models, isEnd in
            guard let self = self else { return }
            guard error == nil, let models = models, models.count > 0 else { return self.images.accept([]) }
            
            self.images.accept(models)
            self.isEndPage = isEnd ?? true
        }
    }

    private func requestLoadMoreImages() {
        if !isEndPage {
            self.page += 1

            apiManager.requestAPI(search: searchText, page: page) { [weak self] error, models, isEnd in
                guard let self = self else { return }
                guard error == nil, let models = models, models.count > 0 else { return }

                self.images.accept(self.images.value + models)
                self.isEndPage = isEnd ?? true
            }
        }
    }
}
