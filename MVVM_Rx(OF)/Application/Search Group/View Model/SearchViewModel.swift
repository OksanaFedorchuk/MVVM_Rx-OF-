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
    let pageCounterSubject = BehaviorRelay(value: 94)//PublishSubject<Int>()
    
    // Outputs
    //    var loading: Driver<Bool>
    var repos: Driver<[RepoViewModel]>?
    //    var selectedRepoId: Driver<Int>
    
    let fetchMoreDatas = PublishSubject<Void>()
//    private var pageCounter = 1
    private var maxValue = 1
    private var isPaginationRequestStillResume = false
    
    private let networkingService: GitHubAPI
    private let disposeBag = DisposeBag()
    
    init(networkingService: GitHubAPI) {
//        bind()
        self.networkingService = networkingService
        
        getMyRepos()
        //        let loading = ActivityIndicator()
        //        self.loading = loading.asDriver()
        
//        let initialRepos = self.viewWillAppearSubject
//            .asObservable()
//            .flatMap { _ in
//
//                networkingService.getRepos(withQuery: "swift", for: url, page: 1)
////                pageCounter += 1
//                //                networkingService
//                //                    .execute(url: url)
//                //                    .searchRepos(withQuery: "swift")
//                //                    .trackActivity(loading)
//            }
//            .map({ response in
//                return response[0].items
//            })
//            .asDriver(onErrorJustReturn: [])
        
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
        let url = networkingService.setReposUlr(matching: "swift", sortedBy: .numberOfStars, inOrder: .descending, perPage: "30", page: "20")
        let repos = getContent()
            .asObservable()
//            .subscribe(onNext: { str, int in
//                networkingService.getRepos(withQuery: str, for: url, page: int)
//            })
//            .filter { str, int in
//                str.count > 2
//            }
//            .throttle(RxTimeInterval.seconds(1), scheduler: MainScheduler.instance)
//            .distinctUntilChanged()
            .flatMapLatest { str, int in
                self.networkingService.getRepos(withQuery: str, for: url, page: int)
            }
            .map({ response in
                return response[0].items
            })
            .asDriver(onErrorJustReturn: [])
        
//        let nextPageRepos = self.pageCounterSubject
//            .asObservable()
            
        
//        let repos =  Driver.merge(searchRepos)
        
        self.repos = repos.map { $0.map { RepoViewModel(repo: $0)} }
    }
    
    func getContent() -> Observable<(searchText: String, page: Int)> {
         return Observable
           .combineLatest(
            searchQuerySubject.asObservable(),
             pageCounterSubject.asObservable(),
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
