//
//  DetailsController.swift
//  MVVM_Rx(OF)
//
//  Created by MacBook Air on 20.12.2021.
//

import UIKit
import RxSwift
import RxCocoa

class DetailsController: UIViewController, UIScrollViewDelegate {
    
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
    
    override func loadView() {
        setupScroll()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        detailsView.configure(with: vm.movie ?? Movie())
        setupUI()
        bindVM()
        setButtonTargets()
    }
    
    // MARK: - Private methods
    
    private func setupUI() {
        view.backgroundColor = .white
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.tintColor = UIColor.white
        navigationController?.navigationBar.backgroundColor = .clear
        navigationController?.navigationBar.barStyle = .black
    }
    
    private func setupScroll() {
        view = UIView()
        let scrollView = UIScrollView()
        scrollView.delegate = self
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        detailsView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(scrollView)
        scrollView.addSubview(detailsView)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor, constant: -150),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            detailsView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            detailsView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            detailsView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            detailsView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            detailsView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
        ])
    }
    
    private func setButtonTargets() {
        //        detailsView.viewOnlineButton.addTarget(self, action: #selector(didTapViewOnline), for: .touchUpInside)
        //        detailsView.shareButtonaddTarget(.self, action: #selector(didTapShare), for: .touchUpInside)
    }
    
    private func bindVM() {
        //         -- tableview binding --
        vm.movieProductionCompanies.drive(detailsView.detailsTable.rx.items(cellIdentifier: DetailsTableCell.identifier, cellType: DetailsTableCell.self)) { (row, element, cell) in
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
        
        detailsView.viewOnlineButton.rx.tap.bind { [self] in
            vm.getlink()
            print("Tapped: \(vm.movieLink)")
            if vm.movieLink == "" {
                if let url = vm.movie?.posterURL {
                    UIApplication.shared.open(url)
                }
            } else      {
                if let url = URL(string: vm.movieLink) {
                    UIApplication.shared.open(url)
                }
            }
        }
        .disposed(by: disposeBag)
    }
}
