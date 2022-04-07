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
        let viewModel = SearchViewModel(networkingService: MovieDBAPI())
        let viewController = SearchController(viewModel: viewModel)
        navigationController.pushViewController(viewController, animated: false)
    }
}
