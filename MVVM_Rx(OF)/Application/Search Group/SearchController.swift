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
    }
    
    private func bindVM() {
        
        rx.viewWillAppear
            .asObservable()
            .bind(to: vm.viewWillAppearSubject)
            .disposed(by: disposeBag)
        
        vm.repos
            .drive(searchView.tableView.rx.items(cellIdentifier: SearchTableCell.identifier, cellType: SearchTableCell.self)) { (row, element, cell) in
                cell.secondTeamLabel.text = element.name
            }
            .disposed(by: disposeBag)
    }
}

extension Reactive where Base: UIViewController {
    var viewWillAppear: ControlEvent<Void> {
        let source = self.methodInvoked(#selector(Base.viewWillAppear(_:))).map { _ in }
        return ControlEvent(events: source)
    }
}
