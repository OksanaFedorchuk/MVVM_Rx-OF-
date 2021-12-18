//
//  SearchController.swift
//  MVVM_Rx(OF)
//
//  Created by MacBook Air on 18.12.2021.
//

import UIKit

class SearchController: UIViewController {
    
    private let searchView = SearchView()

    override func viewDidLoad() {
        super.viewDidLoad()
        searchView.frame = view.bounds
        view.backgroundColor = .cyan
    }
}

