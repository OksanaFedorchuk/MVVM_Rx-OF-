//
//  SearchView.swift
//  MVVM_Rx(OF)
//
//  Created by MacBook Air on 18.12.2021.
//

import UIKit

class SearchView: UIView {
    
    private var container: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    public var tableView: UITableView = {
        let table = UITableView()
        table.backgroundColor = .white
        table.translatesAutoresizingMaskIntoConstraints = false
        table.register(SearchTableCell.self, forCellReuseIdentifier: SearchTableCell.identifier)
        return table
    }()
    
    public var searchBar: UISearchBar = {
        let sb = UISearchBar()
        sb.translatesAutoresizingMaskIntoConstraints = false
        return sb
    }()
    
    // MARK: -  Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        addSubviews()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    private func addSubviews() {
        addSubview(container)
        container.addSubview(searchBar)
        container.addSubview(tableView)
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            
            container.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            container.leadingAnchor.constraint(equalTo: leadingAnchor),
            container.trailingAnchor.constraint(equalTo: trailingAnchor),
            container.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            searchBar.leadingAnchor.constraint(equalTo: container.leadingAnchor),
            searchBar.topAnchor.constraint(equalTo: container.topAnchor),
            searchBar.trailingAnchor.constraint(equalTo: container.trailingAnchor),
            searchBar.bottomAnchor.constraint(equalTo: tableView.topAnchor),
            
            tableView.leadingAnchor.constraint(equalTo: container.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: container.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: container.bottomAnchor),
        ])
    }
}
