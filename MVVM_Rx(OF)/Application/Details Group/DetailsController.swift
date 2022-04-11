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
    
    private var detailsView = DetailsView()
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
        detailsView.configure(with: vm.movie ?? Movie())
        setupUI()
        bindVM()
    }
    
    private func setupUI() {
        view.addSubview(detailsView)
        detailsView.frame = view.bounds
        view.backgroundColor = .white
        
        navigationController?.navigationBar.tintColor = UIColor.white
        navigationController?.navigationBar.barStyle = .black
    }
    
    private func bindVM() {
        //         -- tableview binding --
        vm.movieReviews.drive(detailsView.detailsTable.rx.items(cellIdentifier: DetailsTableCell.identifier, cellType: DetailsTableCell.self)) { (row, element, cell) in
            cell.configure(with: element)
            URLSession.shared.rx
                .response(request: URLRequest(url: element.logoURL))
            // subscribe on main thread
                .subscribe(on: MainScheduler.asyncInstance)
                .subscribe(onNext: { [weak self] data in
                    // Update Image
                    
                    DispatchQueue.main.async {
                        cell.image.image = UIImage(data: data.data)
                    }
                }, onError: {_ in
                    // Log error
                }).disposed(by: self.disposeBag)
        }
        .disposed(by: disposeBag)
        
        
        URLSession.shared.rx
            .response(request: URLRequest(url: vm.movie?.backdropURL ?? URL(string: "https://api.github.com/zen")!))
        // subscribe on main thread
            .subscribe(on: MainScheduler.asyncInstance)
            .subscribe(onNext: { [weak self] data in
                // Update Image
                DispatchQueue.main.async {
                    self?.detailsView.image.image = UIImage(data: data.data) ?? UIImage()
                }
                
            }, onError: {_ in
                // Log error
            }).disposed(by: disposeBag)
    }
}
