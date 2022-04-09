//
//  DetailsViewModel.swift
//  MVVM_Rx(OF)
//
//  Created by MacBook Air on 21.12.2021.
//

import Foundation
import RxSwift
import RxCocoa

final class DetailsViewModel {
    
    //inputs
    let selectedIndexSubject = PublishSubject<IndexPath>()
    
    //outputs
    var moviesDriven = BehaviorDriver<[Movie]>(value: [])
    var selectedMovie: Driver<Movie>?
    
    private let disposeBag = DisposeBag()
    
    init() {
        bindSelected()
    }
    
    private func bindSelected() {
        self.selectedMovie = self.selectedIndexSubject
            .asObservable()
            .withLatestFrom(moviesDriven.behavior) { (indexPath, movies) -> Movie in
                return movies[indexPath.item]
            }
            .asDriver(onErrorJustReturn: Movie())
    }
}
