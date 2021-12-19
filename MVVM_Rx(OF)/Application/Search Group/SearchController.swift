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
        
        title = "GitHub Repo Search"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func bindVM() {
        
        rx.viewWillAppear
            .asObservable()
            .bind(to: vm.viewWillAppearSubject)
            .disposed(by: disposeBag)
        
        vm.repos!
            .drive(searchView.tableView.rx.items(cellIdentifier: SearchTableCell.identifier, cellType: SearchTableCell.self)) { (row, element, cell) in
                cell.secondTeamLabel.text = element.name
            }
            .disposed(by: disposeBag)
        
        searchView.tableView.rx.didScroll.subscribe { [weak self] _ in
                    guard let self = self else { return }
            let offSetY = self.searchView.tableView.contentOffset.y
            let contentHeight = self.searchView.tableView.contentSize.height

            if offSetY > (contentHeight - self.searchView.tableView.frame.size.height - 100) {
//                        self.vm.fetchMoreDatas.onNext(())
                print("MYDEBUG: must refresh now")
                    }
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
