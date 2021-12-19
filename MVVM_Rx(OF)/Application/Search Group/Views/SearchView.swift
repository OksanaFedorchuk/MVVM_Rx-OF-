//
//  SearchView.swift
//  MVVM_Rx(OF)
//
//  Created by MacBook Air on 18.12.2021.
//

import UIKit

class SearchView: UIView {
    
    public var tableView: UITableView = {
        let table = UITableView()
        table.backgroundColor = .cyan
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
        backgroundColor = .cyan.withAlphaComponent(0.3)
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
        addSubview(tableView)
        addSubview(searchBar)
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            
            searchBar.leadingAnchor.constraint(equalTo: leadingAnchor),
            searchBar.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            searchBar.trailingAnchor.constraint(equalTo: trailingAnchor),
            searchBar.bottomAnchor.constraint(equalTo: tableView.topAnchor),
            
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
}
