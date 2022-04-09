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
    private let api = MovieDBAPI()
    private let disposeBag = DisposeBag()
    
    let vm: SearchViewModel
    private var counter = 0
    private var pageNumber = 0
    
    // MARK: -  Inits
    
    init(viewModel: SearchViewModel) {
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
        bindAlertOnTap()
    }
    
    // MARK: -  Methods
    
    private func setupUI() {
        view.addSubview(searchView)
        searchView.frame = view.bounds
        view.backgroundColor = .cyan
        
        title = "MovieDB Search"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.setRightBarButton(historyButton, animated: false)
    }
    
    private func bindVM() {
        
        // -- tableview binding --
        vm.moviesDriven.driver.drive(searchView.tableView.rx.items(cellIdentifier: SearchTableCell.identifier, cellType: SearchTableCell.self)) { [self] (row, element, cell) in
            cell.movieTitleLabel.text = element.title
            cell.ratingLabel.text = "\(element.voteAverage)"
            URLSession.shared.rx
                .response(request: URLRequest(url: element.imageURL))
            // subscribe on main thread
                .subscribe(on: MainScheduler.asyncInstance)
                .subscribe(onNext: { [weak self] data in
                    // Update Image
                    
                    DispatchQueue.main.async {
                        cell.image.image = UIImage(data: data.data)
                    }
                }, onError: {_ in
                    // Log error
                }).disposed(by: disposeBag)
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
                
                guard let strongSelf = self else {return}
                
                if indexPath.row == (strongSelf.counter - 2) {
                    
                    strongSelf.vm.pageCounterSubject.accept(strongSelf.pageNumber)
                    
                    if strongSelf.vm.count > strongSelf.pageNumber {
                        strongSelf.pageNumber += 1
                    }
                }
            })
            .disposed(by: disposeBag)
        
        // -- binding for number items --
        vm.moviesDriven.behavior
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
    
    @objc private func didTapHistory() {
        let historyVC = DetailsController()
        navigationController?.pushViewController(historyVC, animated: true)
    }
}
