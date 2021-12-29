//
//  HistoryViewModel.swift
//  MVVM_Rx(OF)
//
//  Created by MacBook Air on 21.12.2021.
//

import Foundation
import RxSwift
import RxCocoa

final class HistoryViewModel {
    
    let selectedIndexSubject = PublishSubject<IndexPath>()
    
    var moviesDriven = BehaviorDriver<[MoviewViewModel]>(value: [])
    var selectedMovie: Driver<MoviewViewModel>?
    
    private let disposeBag = DisposeBag()
    
    init() {
        subscriveToSavedMovies()
        bindSelected()
    }
    
    private func subscriveToSavedMovies() {
        UserDefaults.standard.rx
            .observe([Data].self, "movies")
            .map({ data -> [Movie] in
                guard let movies = UserDefaults.standard.array(forKey: "movies") as? [Data] else {return []}
                return movies.map { try! JSONDecoder().decode(Movie.self, from: $0) }
            })
            .map{ $0.map { MoviewViewModel(movie: $0)} }
            .bind(onNext: { [weak self] movies in
                self?.moviesDriven.accept(movies)
            })
            .disposed(by: disposeBag)
    }
    
    private func bindSelected() {
        self.selectedMovie = self.selectedIndexSubject
            .asObservable()
            .withLatestFrom(moviesDriven.behavior) { (indexPath, movies) -> MoviewViewModel in
                return movies[indexPath.item]
            }
            .asDriver(onErrorJustReturn: MoviewViewModel(id: 0,
                                                         title: "Movie Error",
                                                         overview: "Was no able to get the selected movie",
                                                         posterPath: ""))
    }
}
