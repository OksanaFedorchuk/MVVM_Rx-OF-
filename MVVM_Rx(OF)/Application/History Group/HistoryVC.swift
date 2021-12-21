//
//  HistoryVC.swift
//  MVVM_Rx(OF)
//
//  Created by MacBook Air on 20.12.2021.
//

import UIKit
import RxSwift
import RxCocoa

class HistoryVC: UIViewController {
    
    private let historyView = HistoryView()
    private let vm = HistoryViewModel()
    private let disposeBag = DisposeBag()
    
    // MARK: -  Inits
    
    init() {
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
    }
    
    private func setupUI() {
        view.addSubview(historyView)
        historyView.frame = view.bounds
        view.backgroundColor = .white
        
        title = "GitHub Repo Search"
        navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    private func bindVM() {
        // -- tableview binding --
        vm.reposDriven.driver.drive(historyView.historyTable.rx.items(cellIdentifier: SearchTableCell.identifier, cellType: SearchTableCell.self)) { (row, element, cell) in
            cell.secondTeamLabel.text = element.name
        }
        .disposed(by: disposeBag)
    }
}
