//
//  DetailsController.swift
//  MVVM_Rx(OF)
//
//  Created by MacBook Air on 20.12.2021.
//

import UIKit
import RxSwift
import RxCocoa

class DetailsController: UIViewController {
    
    private let historyView = DetailsView()
    private let vm: DetailsViewModel
    private let disposeBag = DisposeBag()
    
    // MARK: -  Inits
    
    init(vm: DetailsViewModel) {
        self.vm = vm
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
        
    }
    
    private func bindVM() {
        // -- tableview binding --
//        vm.moviesDriven.driver.drive(historyView.detailsTable.rx.items(cellIdentifier: SearchTableCell.identifier, cellType: SearchTableCell.self)) { (row, element, cell) in
//            cell.movieTitleLabel.text = element.title
//        }
//        .disposed(by: disposeBag)
        
//        //selected index binding
//        historyView.detailsTable.rx.itemSelected
//            .asObservable()
//            .bind(to: vm.selectedIndexSubject)
//            .disposed(by: disposeBag)
        
//        // -- binding to selected cell in tableview --
//        historyView.detailsTable.rx.itemSelected
//            .asObservable()
//            .bind(to: vm.selectedIndexSubject)
//            .disposed(by: disposeBag)
    }
    
    private func bindAlertOnTap() {
        // -- Showing alert with movie --
//        vm.selectedMovie?
//            .drive(onNext: { [weak self] movie in
//                guard let strongSelf = self else { return }
//                let alertController = UIAlertController(title: "\(movie.title)", message: nil, preferredStyle: .alert)
//                alertController.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
//                strongSelf.present(alertController, animated: true, completion: nil)
//            })
//            .disposed(by: disposeBag)
    }
}
