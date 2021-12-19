//
//  SearchViewModel.swift
//  MVVM_Rx(OF)
//
//  Created by MacBook Air on 18.12.2021.
//

import RxSwift
import RxCocoa

final class ReposViewModel {
    // Inputs
    let viewWillAppearSubject = PublishSubject<Void>()
    //    let selectedIndexSubject = PublishSubject<IndexPath>()
    let searchQuerySubject = BehaviorSubject(value: "more")
    let pageCounterSubject = BehaviorRelay(value: 1)//PublishSubject<Int>()
    
    // Outputs
    //    var loading: Driver<Bool>
    var repos: Driver<[RepoViewModel]>?
    var count = PublishSubject<Int>()
    //    var selectedRepoId: Driver<Int>
    
    private let networkingService: GitHubAPI
    private let disposeBag = DisposeBag()
    
    init(networkingService: GitHubAPI) {
        //        bind()
        self.networkingService = networkingService
        
        getMyRepos()
        //        let loading = ActivityIndicator()
        //        self.loading = loading.asDriver()
        
        //                let searchRepos = self.searchQuerySubject
        //                    .asObservable()
        //                    .filter { $0.count > 2}
        //                    .throttle(RxTimeInterval.seconds(1), scheduler: MainScheduler.instance)
        //                    .distinctUntilChanged()
        //                    .flatMapLatest { query in
        //                        networkingService.getRepos(withQuery: query, for: url, page: 2)
        ////                            .searchRepos(withQuery: query)
        //        //                    .trackActivity(loading)
        //                    }
        //                    .map({ response in
        //                        return response[0].items
        //                    })
        //                    .asDriver(onErrorJustReturn: [])
        
        //        self.selectedRepoId = self.selectedIndexSubject
        //            .asObservable()
        //            .withLatestFrom(repos) { (indexPath, repos) in
        //                return repos[indexPath.item]
        //            }
        //            .map { $0.id }
        //            .asDriver(onErrorJustReturn: 0)
        
    }
    
    func getMyRepos() {
        
        let nextRepos = getContent()
            .asObservable()
            .debounce(RxTimeInterval.seconds(3), scheduler: MainScheduler.asyncInstance)
            .flatMapLatest { searchStr, pageNum in
                self.networkingService.getRepos(withQuery: searchStr, for: pageNum)
            }
            .map({ response in
                return response[0].items
            })
            .asDriver(onErrorJustReturn: [])
        
        
        //        let repos =  Driver.merge(searchRepos)
        let repos = Driver.merge(nextRepos)
//       let repos = nextRepos.asObservable().bind { repos in
//
//        }
        
        self.repos = repos.map { $0.map { RepoViewModel(repo: $0)} }
    }
    
    func getContent() -> Observable<(searchText: String, page: Int)> {
        return Observable
            .combineLatest(
                searchQuerySubject
                    .asObservable()
                    .filter { str in
                        str.count > 2
                    }
                    .throttle(RxTimeInterval.seconds(1), scheduler: MainScheduler.instance)
                    .distinctUntilChanged(),
                pageCounterSubject
                    .asObservable()
                    .distinctUntilChanged(),
                resultSelector: { (text, page) -> (searchText: String, page: Int) in
                    return (searchText: text, page: page)
                }
            )
    }
}

struct RepoViewModel {
    let name: String
}

extension RepoViewModel {
    init(repo: Repo) {
        self.name = repo.name
    }
}
