//
//  ObservableType-Extension.swift
//  brandiExample
//
//  Created by HooGi on 2021/11/19.
//

import RxCocoa
import RxSwift

extension ObservableType {
    func asDriverComplete() -> SharedSequence<DriverSharingStrategy, Element> {
        return asDriver(onErrorRecover: { (error)  in
            return Driver.empty()
        })
    }
    
    func mapToVoid() -> Observable<Void> {
        return map { _ in }
    }
}
