//
//  DescViewModel.swift
//  brandiExample
//
//  Created by HooGi on 2021/11/19.
//

import RxCocoa
import RxSwift

final class DescViewModel {
    
    // MARK: - Properties
    private let model: ImageModel
    
    init(model: ImageModel) {
        self.model = model
    }
    
    struct Input {
        let trigger: Driver<Void>
    }
    
    struct Output {
        let imageURL: Driver<URL>
        let imageSize: Driver<CGSize>
        let source: Driver<String>
        let createDate: Driver<Date>
    }
    
    // MARK: - Methods
    func transform(input: Input) -> Output {
        let imageURL: Driver<URL> = input.trigger
            .flatMapLatest { [weak self] _ in
                guard let self = self,
                      let imageURL = self.model.imageURL,
                      let url = URL(string: imageURL) else { return Driver.empty() }
                
                return Driver.just(url)
            }
        
        let imageSize: Driver<CGSize> = input.trigger
            .flatMapLatest { [weak self] _ in
                guard let self = self,
                      let size = self.model.size else { return Driver.empty() }
                
                return Driver.just(size)
            }
        
        let source: Driver<String> = input.trigger
            .flatMapLatest { [weak self] _ in
                guard let self = self,
                      let source = self.model.sourceName else { return Driver.empty() }
                
                if source.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                    return Driver.empty()
                } else {
                    return Driver.just(source)
                }
            }
        
        let createDate: Driver<Date> = input.trigger
            .flatMapLatest { [weak self] _ in
                guard let self = self,
                      let date = self.model.createDate?.toDate() else { return Driver.empty() }
                
                return Driver.just(date)
            }
        
        return Output(imageURL: imageURL, imageSize: imageSize, source: source, createDate: createDate)
    }
    
    // MARK: - Private Methods
    private func filterToEmptyString(str: String) -> String? {
        if str.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            return nil
        } else {
            return str
        }
    }
}
