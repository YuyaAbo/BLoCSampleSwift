//
//  CounterBloc.swift
//  BLoCSample
//
//  Created by 阿保 友也 on 2018/07/02.
//  Copyright © 2018年 阿保 友也. All rights reserved.
//

import Foundation
import RxSwift

final class CounterBloc {

    private let bag = DisposeBag()

    private var _count = BehaviorSubject<Int>(value: 0)
    var count: Observable<String> {
        return _count.asObservable()
            .map { "\($0)" }
    }
    var message: Observable<String> {
        return _count.asObservable()
            .map { 0 <= $0 ? "ぷらすだよ" : "まいなすだよ" }
    }

    enum Arithmetic { case plus, minus }
    private var _calc = PublishSubject<Arithmetic>()
    var calc: PublishSubject<Arithmetic> {
        return _calc
    }

    init() {
        _calc.subscribe(onNext: { [unowned self] (arithmetic: Arithmetic) in
            let currentCount: Int = try! self._count.value()
            switch arithmetic {
            case .minus: self._count.onNext(currentCount - 1)
            case .plus: self._count.onNext(currentCount + 1)
            }
        }).disposed(by: bag)
    }
}
