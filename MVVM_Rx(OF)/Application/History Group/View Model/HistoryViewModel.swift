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
    
    var reposDriven = BehaviorDriver<[RepoViewModel]>(value: [])
    var selectedRepoUrl: Driver<String>?
    
    private let disposeBag = DisposeBag()
    
    init() {
        subscriveToSavedRepos()
        bindUrl()
    }
    
    private func subscriveToSavedRepos() {
        UserDefaults.standard.rx
            .observe([Data].self, "repos")
            .map({ data -> [Repo] in
                guard let repos = UserDefaults.standard.array(forKey: "repos") as? [Data] else {return []}
                return repos.map { try! JSONDecoder().decode(Repo.self, from: $0) }
            })
            .map{ $0.map { RepoViewModel(repo: $0)} }
            .bind(onNext: { [weak self] repos in
                self?.reposDriven.accept(repos)
            })
            .disposed(by: disposeBag)
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
}
