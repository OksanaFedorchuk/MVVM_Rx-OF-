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
    let searchQuerySubject = BehaviorSubject(value: "")
    
    // Outputs
    //    var loading: Driver<Bool>
    var repos: Driver<[RepoViewModel]>
    //    var selectedRepoId: Driver<Int>
    
    private let networkingService: GitHubAPI    
    
    init(networkingService: GitHubAPI) {
        self.networkingService = networkingService
        
        
        //        let loading = ActivityIndicator()
        //        self.loading = loading.asDriver()
        let url = networkingService.setReposUlr(matching: "swift", sortedBy: .numberOfStars, inOrder: .descending, perPage: "30")
        let initialRepos = self.viewWillAppearSubject
            .asObservable()
            .flatMap { _ in
                networkingService.getRepos(withQuery: "swift", for: url)
                //                networkingService
                //                    .execute(url: url)
                //                    .searchRepos(withQuery: "swift")
                //                    .trackActivity(loading)
            }
            .map({ response in
                return response[0].items
            })
            .asDriver(onErrorJustReturn: [])
        
        //        let searchRepos = self.searchQuerySubject
        //            .asObservable()
        //            .filter { $0.count > 2}
        //            .throttle(RxTimeInterval.seconds(1), scheduler: MainScheduler.instance)
        //            .distinctUntilChanged()
        //            .flatMapLatest { query in
        //                networkingService
        //                    .searchRepos(withQuery: query)
        ////                    .trackActivity(loading)
        //            }
        //            .asDriver(onErrorJustReturn: [])
        
        let repos = initialRepos //Driver.merge(initialRepos, searchRepos)
        
        self.repos = repos.map { $0.map { RepoViewModel(repo: $0)} }
        
        //        self.selectedRepoId = self.selectedIndexSubject
        //            .asObservable()
        //            .withLatestFrom(repos) { (indexPath, repos) in
        //                return repos[indexPath.item]
        //            }
        //            .map { $0.id }
        //            .asDriver(onErrorJustReturn: 0)
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
