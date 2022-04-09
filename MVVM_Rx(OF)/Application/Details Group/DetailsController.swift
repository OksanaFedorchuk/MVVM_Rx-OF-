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
    }
    
    private func setupUI() {
        view.addSubview(historyView)
        historyView.frame = view.bounds
        view.backgroundColor = .white
        
    }
    
    private func bindVM() {
        //         -- tableview binding --
        vm.selectedMovieReviews?.drive(historyView.detailsTable.rx.items(cellIdentifier: DetailsTableCell.identifier, cellType: DetailsTableCell.self)) { (row, element, cell) in
        }
        .disposed(by: disposeBag)
    }
}
