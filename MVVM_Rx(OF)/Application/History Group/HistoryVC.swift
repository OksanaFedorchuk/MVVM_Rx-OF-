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
        bindAlertOnTap()
    }
    
    private func setupUI() {
        view.addSubview(historyView)
        historyView.frame = view.bounds
        view.backgroundColor = .white
        
        title = "Tapped Movies"
        navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    private func bindVM() {
        // -- tableview binding --
        vm.moviesDriven.driver.drive(historyView.historyTable.rx.items(cellIdentifier: SearchTableCell.identifier, cellType: SearchTableCell.self)) { (row, element, cell) in
            cell.secondTeamLabel.text = element.title
        }
        .disposed(by: disposeBag)
        
        //selected index binding
        historyView.historyTable.rx.itemSelected
            .asObservable()
            .bind(to: vm.selectedIndexSubject)
            .disposed(by: disposeBag)
        
        // -- binding to selected cell in tableview --
        historyView.historyTable.rx.itemSelected
            .asObservable()
            .bind(to: vm.selectedIndexSubject)
            .disposed(by: disposeBag)
    }
    
    private func bindAlertOnTap() {
        // -- Showing alert with movie --
        vm.selectedMovie?
            .drive(onNext: { [weak self] movie in
                guard let strongSelf = self else { return }
                let alertController = UIAlertController(title: "\(movie.title)", message: nil, preferredStyle: .alert)
                alertController.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                strongSelf.present(alertController, animated: true, completion: nil)
            })
            .disposed(by: disposeBag)
    }
}
