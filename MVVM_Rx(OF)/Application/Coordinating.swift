//
//  Coordinating.swift
//  MVVM_Rx(OF)
//
//  Created by Oksana Fedorchuk on 07.04.2022.
//

import UIKit

protocol Coordinating {
    var navigationController: UINavigationController { get set }
    func start()
}
