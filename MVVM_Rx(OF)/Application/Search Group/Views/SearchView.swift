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
        table.separatorColor = .clear
        return table
    }()
    
    public var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.backgroundImage = UIImage()
        return searchBar
    }()
    
    // MARK: -  Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        addSubviews()
        setConstraints()
        setupTableHeader()
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
            
            searchBar.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 8),
            searchBar.topAnchor.constraint(equalTo: container.topAnchor),
            searchBar.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -8),
            searchBar.bottomAnchor.constraint(equalTo: tableView.topAnchor),
            
            tableView.leadingAnchor.constraint(equalTo: container.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: container.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: container.bottomAnchor),
        ])
    }
    
    private func setupTableHeader() {
        let headerView: UIView = UIView.init(frame: CGRect(x: 12, y: 50, width: 276, height: 30))
        
        let label: UILabel = UILabel.init(frame: CGRect(x: 16, y: 5, width: 276, height: 24))
        label.text = "Movies"
        label.font = .systemFont(ofSize: 28, weight: .bold)
        
        headerView.addSubview(label)
        self.tableView.tableHeaderView = headerView
    }
}
