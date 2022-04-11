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
    var movieLink: String { get set }
    var movieProductionCompanies: Driver<[ProductionCompany]> { get set }
    
    func getlink()
}

final class DetailsViewModel: MovieDetailsProvideable {
    
    // MARK: - Properties
    
    //inputs
    var movie: Movie?
    
    //outputs
    var movieProductionCompanies: Driver<[ProductionCompany]>
    var movieLink = ""
    
    private let networkingService = MovieDBAPI()
    private let disposeBag = DisposeBag()
    
    // MARK: - Init
    
    init(movie: Movie) {
        self.movie = movie
        
        movieProductionCompanies = networkingService
            .getMovieDetails(for: movie.id)
            .map({ result -> [ProductionCompany] in
                return result.first?.productionCompanies ?? [ProductionCompany]()
            })
            .asDriver(onErrorJustReturn: [ProductionCompany]())
        
        getlink()
    }
    
    // MARK: - Private methods
    
    func getlink() {
        networkingService
            .getMovieDetails(for: movie?.id ?? 0)
            .bind(onNext: { [weak self] results in
                self?.movieLink = results.first?.homepage ?? ""
            })
            .disposed(by: disposeBag)
    }
}
