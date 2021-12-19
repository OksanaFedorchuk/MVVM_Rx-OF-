//
//  SearchController.swift
//  MVVM_Rx(OF)
//
//  Created by MacBook Air on 18.12.2021.
//

import UIKit
import RxSwift
import RxCocoa

class SearchController: UIViewController {
    
    private let searchView = SearchView()
    private let api = GitHubAPI()
    private let disposeBag = DisposeBag()
    
    let vm: ReposViewModel
    private var counter = 0
    private var pageNumber = 2
    
    init(viewModel: ReposViewModel) {
        self.vm = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        bindVM()
    }
    
    private func setupUI() {
        view.addSubview(searchView)
        searchView.frame = view.bounds
        view.backgroundColor = .cyan
        
        title = "GitHub Repo Search"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func bindVM() {
        
        vm.reposDriven.driver.drive(searchView.tableView.rx.items(cellIdentifier: SearchTableCell.identifier, cellType: SearchTableCell.self)) { (row, element, cell) in
            cell.secondTeamLabel.text = element.name
        }
        .disposed(by: disposeBag)
        
        //            .bind(to: searchView.tableView.rx.items(cellIdentifier: SearchTableCell.identifier, cellType: SearchTableCell.self) ) { (row, element, cell) in
        //            cell.secondTeamLabel.text = element.name
        //        }
        //        .disposed(by: disposeBag)
        
        vm.reposDriven.behavior
            .map { $0.count }
            .bind(onNext: { [weak self] num in
                self?.counter = num
            })
            .disposed(by: disposeBag)
        
        
        searchView.tableView.rx
            .willDisplayCell
            .subscribe(onNext: { [weak self] cell, indexPath in
                if indexPath.row == (self!.counter - 2) {
                    self?.vm.pageCounterSubject.accept(self?.pageNumber ?? 2)
                    self?.pageNumber += 1
                }
            })
            .disposed(by: disposeBag)
        
        searchView.searchBar.rx.text.orEmpty
            .asObservable()
            .bind(to: vm.searchQuerySubject)
            .disposed(by: disposeBag)
    }
}

extension Reactive where Base: UIViewController {
    var viewWillAppear: ControlEvent<Void> {
        let source = self.methodInvoked(#selector(Base.viewWillAppear(_:))).map { _ in }
        return ControlEvent(events: source)
    }
}
