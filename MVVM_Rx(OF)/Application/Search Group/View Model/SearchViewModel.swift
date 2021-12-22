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
    let searchQuerySubject = BehaviorRelay(value: "")
    let pageCounterSubject = BehaviorRelay(value: 1)
    
    // Outputs
    var reposDriven = BehaviorDriver<[RepoViewModel]>(value: [])
    var count = Int()
    var selectedRepoUrl: Driver<String>?
    
    private let networkingService: GitHubAPI
    private let disposeBag = DisposeBag()
    
    private var isNew = false
    
    init(networkingService: GitHubAPI) {
        self.networkingService = networkingService
        
        subscribeToSearch()
        bindUrl()
        subscribeRepoSaving()
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
    
    private func subscribeRepoSaving() {
        selectedIndexSubject
            .asObserver()
            .withLatestFrom(reposDriven.behavior) { (indexPath, repos) -> RepoViewModel in
                return repos[indexPath.item]
            }
            .map{ Repo(repo: $0) }
            .bind { repo in
                SavedRepos.savedRepos.append(repo)
            }
            .disposed(by: disposeBag)
    }
    
    private func subscribeToSearch() {
        
        publishTextAndPage()
            .asObservable()
            .flatMapLatest { searchStr, pageNum in
                self.networkingService.getRepos(withQuery: searchStr, for: pageNum)
            }
            .map({ [weak self] response -> [Repo] in
                self?.count = response[0].count
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
                    .throttle(RxTimeInterval.milliseconds(500), scheduler: MainScheduler.instance)
                    .distinctUntilChanged(),
                pageCounterSubject
                    .asObservable()
                    .distinctUntilChanged(),
                resultSelector: { [weak self] (text, page) -> (searchText: String, page: Int) in
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
