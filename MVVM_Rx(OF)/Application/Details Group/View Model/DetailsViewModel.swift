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
    var movieReviews: Driver<[ProductionCompany]>
    
    private let networkingService = MovieDBAPI()
    private let disposeBag = DisposeBag()
    
    init(movie: Movie) {
        self.movie = movie
        movieReviews = networkingService
            .getMovieDetails(for: movie.id)
            .map({ result -> [ProductionCompany] in
                for company in result[0].productionCompanies {
                    print("MYDEBUG: production company: \(company.name)")
                }
                return result[0].productionCompanies
            })
            .asDriver(onErrorJustReturn: [ProductionCompany]())
    }
}
