//
//  SearchViewModel.swift
//  MVVM_Rx(OF)
//
//  Created by MacBook Air on 18.12.2021.
//

import RxSwift
import RxCocoa

final class SearchViewModel {
    
    // MARK: - Properties
    
    // Inputs
    let selectedIndexSubject = PublishSubject<IndexPath>()
    let searchQuerySubject = BehaviorRelay(value: "")
    let pageCounterSubject = BehaviorRelay(value: 1)
    
    // Outputs
    var moviesDriven = BehaviorDriver<[Movie]>(value: [])
    var count = Int()
    var selectedMovie: Driver<Movie>?
    
    private let networkingService = MovieDBAPI()
    private let disposeBag = DisposeBag()
    
    private var isNew = false
    
    // MARK: - Inits
    
    init() {
        
        subscribeToSearch()
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
    
    // MARK: - Methods
    
    private func subscribeToSearch() {
        
        publishTextAndPage()
            .asObservable()
            .flatMapLatest { searchStr, pageNum in
                self.networkingService.getMovie(withQuery: searchStr, for: pageNum)
                    .catch { [weak self] error in
                        // TODO: display error on placeholder text
                        print("MYDEBUG Error publishTextAndPage url : \(error.localizedDescription)")
                        return Observable
                            .just([MoviesResult.init(totalPages: 0,
                                                     movies: [])
                            ])
                    }
            }
            .map { [weak self] response -> [Movie] in
                self?.count = response.first?.totalPages ?? 0
                return response.first?.movies ?? []
            }
            .bind(onNext: { [weak self] items in
                guard let self = self else { return }
                let sortedItems = items.sorted { $0.voteAverage > $1.voteAverage }
                if self.isNew {
                    //this method resets search results
                    self.moviesDriven.accept(sortedItems)
                    self.isNew.toggle()
                } else {
                    //this method adds up pages to search results
                    if self.moviesDriven.value() != sortedItems {
                        self.moviesDriven.behavior.accept((self.moviesDriven.value()) + sortedItems)
                    }
                }
            })
            .disposed(by: disposeBag)
        
        searchQuerySubject.asObservable()
            .bind { [weak self] _ in
                self?.isNew.toggle()
            }
            .disposed(by: disposeBag)
    }
    
    private func publishTextAndPage() -> Observable<(searchText: String, page: Int)> {
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
