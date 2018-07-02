//
//  ViewController.swift
//  BLoCSample
//
//  Created by 阿保 友也 on 2018/07/02.
//  Copyright © 2018年 阿保 友也. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

final class ViewController: UIViewController {

    @IBOutlet private weak var countLabel: UILabel!
    @IBOutlet private weak var minusButton: UIButton!
    @IBOutlet private weak var plusButton: UIButton!

    private let bag = DisposeBag()
    private let counterBloc = CounterBloc(repository: CounterRepository())

    override func viewDidLoad() {
        super.viewDidLoad()

        counterBloc.count.bind(to: countLabel.rx.text)
            .disposed(by: bag)

        counterBloc.isMinusEnabled.bind(to: minusButton.rx.isEnabled)
            .disposed(by: bag)

        minusButton.rx.tap.subscribe(onNext: { [weak self] (_) in
            self?.counterBloc.calc.onNext(.minus)
        }).disposed(by: bag)

        plusButton.rx.tap.subscribe(onNext: { [weak self] (_) in
            self?.counterBloc.calc.onNext(.plus)
        }).disposed(by: bag)
    }

}

