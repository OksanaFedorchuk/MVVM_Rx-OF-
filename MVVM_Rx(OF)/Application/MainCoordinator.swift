//
//  MainCoordinator.swift
//  MVVM_Rx(OF)
//
//  Created by Oksana Fedorchuk on 07.04.2022.
//

import UIKit

class MainCoordinator: Coordinating {
    
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let viewModel = SearchViewModel()
        let viewController = SearchController(viewModel: viewModel, coordinator: self)
        navigationController.pushViewController(viewController, animated: false)
    }
    
    func presentDetails(for movie: Movie) {
        let viewModel = DetailsViewModel(movie: movie)
        let viewController = DetailsController(vm: viewModel)
        navigationController.pushViewController(viewController, animated: false)
    }
}
