//
//  chooceCategoryViewModel.swift
//  Design engineering
//
//  Created by Mohamed Ali on 28/04/2022.
//

import Foundation
import RxSwift
import RxRelay
import RxGesture

class chooceCategoryViewModel {
    
    // MARK: TODO: This Section for initialise new Rx varibles.
    var choiceBehaviour = BehaviorRelay<Bool>(value: false)
    
    let disposebag = DisposeBag()
    
    
    // MARK: TODO: This Method for handle UI Elements.
    func SetActive() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.choiceBehaviour.accept(true)
        }
    }
    // -------------------------------------------
    
    
    // MARK: TODO: This Method For adding tab Geuester to the view.
    func AddGuester (view: UIView, completion: @escaping (Bool) -> ()) {
        view.rx.tapGesture().when(.recognized).subscribe(onNext: { _ in
            completion(true)
        }).disposed(by: disposebag)
    }
    // -------------------------------------------
}
