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
    
    // MARK: -  Properties
    
    private lazy var historyButton: UIBarButtonItem = {
        let button = UIBarButtonItem(image: UIImage(systemName: "clock.arrow.circlepath"), style: .plain, target: self, action: #selector(didTapHistory))
        button.tintColor = UIColor.blue
        return button
    }()
    
    private let searchView = SearchView()
    private let api = GitHubAPI()
    private let disposeBag = DisposeBag()
    
    let vm: ReposViewModel
    private var counter = 0
    private var pageNumber = 0
    
    // MARK: -  Inits
    
    init(viewModel: ReposViewModel) {
        self.vm = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: -  Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        bindVM()
        bindNavigation()
    }
    
    // MARK: -  Methods
    
    private func setupUI() {
        view.addSubview(searchView)
        searchView.frame = view.bounds
        view.backgroundColor = .cyan
        
        title = "GitHub Repo Search"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.setRightBarButton(historyButton, animated: false)
    }
    
    private func bindVM() {
        
        // -- tableview binding --
        vm.reposDriven.driver.drive(searchView.tableView.rx.items(cellIdentifier: SearchTableCell.identifier, cellType: SearchTableCell.self)) { (row, element, cell) in
            cell.secondTeamLabel.text = element.name
        }
        .disposed(by: disposeBag)
        
        // -- searchbar binding --
        searchView.searchBar.rx.text.orEmpty
            .asObservable()
            .bind(to: vm.searchQuerySubject)
            .disposed(by: disposeBag)
        
        // -- pagination binding --
        searchView.tableView.rx
            .willDisplayCell
            .subscribe(onNext: { [weak self] cell, indexPath in
                if indexPath.row == (self!.counter - 2) {
                    guard let strongSelf = self else {return}
                    strongSelf.vm.pageCounterSubject.accept(strongSelf.pageNumber)
                    if strongSelf.vm.count > strongSelf.pageNumber {
                        strongSelf.pageNumber += 1
                    }
                }
            })
            .disposed(by: disposeBag)
        
        // -- binding for number items --
        vm.reposDriven.behavior
            .map { $0.count }
            .bind(onNext: { [weak self] num in
                self?.counter = num
            })
            .disposed(by: disposeBag)
        
        // -- binding to selected cell in tableview --
        searchView.tableView.rx.itemSelected
            .asObservable()
            .bind(to: vm.selectedIndexSubject)
            .disposed(by: disposeBag)
    }
    
    private func bindNavigation() {
        // -- navigation to repo details in browser --
        vm.selectedRepoUrl?
            .drive(onNext: { repoUrl in
                if let url = URL(string: repoUrl) {
                    UIApplication.shared.open(url)
                }
            })
            .disposed(by: disposeBag)
    }
    
    @objc private func didTapHistory() {
        let historyVC = HistoryVC()
        navigationController?.pushViewController(historyVC, animated: true)
    }
}
