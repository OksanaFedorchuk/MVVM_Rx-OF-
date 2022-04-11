//
//  DetailsViewModel.swift
//  MVVM_Rx(OF)
//
//  Created by MacBook Air on 21.12.2021.
//

import Foundation
import RxSwift
import RxCocoa

protocol MovieDetailsProvideable {
    var movie: Movie? { get }
    var movieReviews: Driver<[ProductionCompany]>? { get set }
    func receiveMovies()
}

final class DetailsViewModel {
    
    //inputs
    var movie: Movie?
    
    //outputs
    var movieProductionCompanies: Driver<[ProductionCompany]>
    var movieLink = ""
    
    private let networkingService = MovieDBAPI()
    private let disposeBag = DisposeBag()
    
    init(movie: Movie) {
        self.movie = movie
        
        movieProductionCompanies = networkingService
            .getMovieDetails(for: movie.id)
            .map({ result -> [ProductionCompany] in
                return result[0].productionCompanies
            })
            .asDriver(onErrorJustReturn: [ProductionCompany]())
        
        getlink()
    }
    
    func getlink() {
        networkingService
            .getMovieDetails(for: movie?.id ?? 0)
            .bind(onNext: { [weak self] results in
                self?.movieLink = results[0].homepage
            })
            .disposed(by: disposeBag)
    }
}
