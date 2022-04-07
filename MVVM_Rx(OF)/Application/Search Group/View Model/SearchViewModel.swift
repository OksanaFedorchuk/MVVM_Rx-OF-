//
//  SearchViewModel.swift
//  MVVM_Rx(OF)
//
//  Created by MacBook Air on 18.12.2021.
//

import RxSwift
import RxCocoa

final class SearchViewModel {
    
    // Inputs
    let selectedIndexSubject = PublishSubject<IndexPath>()
    let searchQuerySubject = BehaviorRelay(value: "")
    let pageCounterSubject = BehaviorRelay(value: 1)
    
    // Outputs
    var moviesDriven = BehaviorDriver<[Movie]>(value: [])
    var count = Int()
    var selectedMovie: Driver<Movie>?
    
    private let networkingService: MovieDBAPI
    private let disposeBag = DisposeBag()
    
    private var isNew = false
    
    init(networkingService: MovieDBAPI) {
        self.networkingService = networkingService
        
        subscribeToSearch()
        bindSelected()
        subscribeMovieSaving()
    }
    
    private func bindSelected() {
        self.selectedMovie = self.selectedIndexSubject
            .asObservable()
            .withLatestFrom(moviesDriven.behavior) { (indexPath, movies) -> Movie in
                return movies[indexPath.item]
            }
            .asDriver(onErrorJustReturn: Movie())
    }
    
    private func subscribeMovieSaving() {
        selectedIndexSubject
            .asObserver()
            .withLatestFrom(moviesDriven.behavior) { (indexPath, movies) -> Movie in
                return movies[indexPath.item]
            }
            .bind { movie in
                SavedMovies.savedMovies.append(movie)
            }
            .disposed(by: disposeBag)
    }
    
    private func subscribeToSearch() {
        
        publishTextAndPage()
            .asObservable()
            .flatMapLatest { searchStr, pageNum in
                self.networkingService.getMovie(withQuery: searchStr, for: pageNum)
                    .catch { [weak self] error in
                        // TODO: display error on placeholder text
                        print("Error url : \(error.localizedDescription)")
                        return Observable
                            .just([MoviesResult.init(totalPages: 0,
                                                     movies: [])
                            ])
                    }
            }
            .map { [weak self] response -> [Movie] in
                self?.count = response[0].totalPages
                return response[0].movies ?? []
            }
            .bind(onNext: { [weak self] items in
                
                if self!.isNew {
                    //this method resets search results
                    self?.moviesDriven.accept(items)
                    self?.isNew.toggle()
                } else {
                    //this method adds up pages to search results
                    self?.moviesDriven.behavior.accept((self?.moviesDriven.value())! + items)
                }
            })
            .disposed(by: disposeBag)
        
        searchQuerySubject.asObservable()
            .bind { _ in
                self.isNew.toggle()
            }
            .disposed(by: disposeBag)
    }
    
    func publishTextAndPage() -> Observable<(searchText: String, page: Int)> {
        return Observable
            .combineLatest(
                searchQuerySubject
                    .asObservable()
                    .throttle(RxTimeInterval.milliseconds(500), scheduler: MainScheduler.instance)
                    .distinctUntilChanged(),
                pageCounterSubject
                    .asObservable()
                    .throttle(RxTimeInterval.milliseconds(500), scheduler: MainScheduler.instance)
                    .distinctUntilChanged(),
                resultSelector: { [weak self] (text, page) -> (searchText: String, page: Int) in
                    return (searchText: text, page: page)
                }
            )
    }
}
