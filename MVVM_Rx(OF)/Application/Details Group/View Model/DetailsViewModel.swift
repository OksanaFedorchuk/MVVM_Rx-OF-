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
    var selected: Movie?
    
    //outputs
    var selectedMovieReviews: Driver<[MovieReviewsResult]>?
    
    private let disposeBag = DisposeBag()
    
    init(selected: Movie) {
        self.selected = selected
    }
}
