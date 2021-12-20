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
    let selectedIndexSubject = PublishSubject<IndexPath>()
    let searchQuerySubject = BehaviorRelay(value: "swift")
    let pageCounterSubject = BehaviorRelay(value: 1)
    
    // Outputs
    var reposDriven = BehaviorDriver<[RepoViewModel]>(value: [])
    var count = PublishSubject<Int>()
    var selectedRepoUrl: Driver<String>?
    
    private let networkingService: GitHubAPI
    private let disposeBag = DisposeBag()
    
    private var isNew = false
    
    init(networkingService: GitHubAPI) {
        self.networkingService = networkingService
        
        subscribeToSearch()
        bindUrl()
    }
    
    private func bindUrl() {
        self.selectedRepoUrl = self.selectedIndexSubject
            .asObservable()
            .withLatestFrom(reposDriven.behavior) { (indexPath, repos) -> RepoViewModel in
                return repos[indexPath.item]
            }
            .map { $0.svnURL }
            .asDriver(onErrorJustReturn: "")
    }
    
    private func subscribeToSearch() {
        
        publishTextAndPage()
            .asObservable()
            .debounce(RxTimeInterval.milliseconds(1000), scheduler: MainScheduler.asyncInstance)
            .flatMapLatest { searchStr, pageNum in
                self.networkingService.getRepos(withQuery: searchStr, for: pageNum)
            }
            .map({ response in
                return response[0].items
            })
            .map { $0.map { RepoViewModel(repo: $0)} }
            .bind(onNext: { [weak self] items in
                
                if self!.isNew {
                    //this method resets search results
                    self?.reposDriven.accept(items)
                    self?.isNew.toggle()
                } else {
                    //this method adds up pages to search results
                    self?.reposDriven.behavior.accept((self?.reposDriven.value())! + items)
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

struct RepoViewModel: Equatable {
    let name: String
    let id: Int
    let svnURL: String
}

extension RepoViewModel {
    init(repo: Repo) {
        self.name = repo.name
        self.id = repo.id
        self.svnURL = repo.svnURL
    }
}
