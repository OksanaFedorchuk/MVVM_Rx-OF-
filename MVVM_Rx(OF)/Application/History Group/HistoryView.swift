//
//  HistoryView.swift
//  MVVM_Rx(OF)
//
//  Created by MacBook Air on 21.12.2021.
//

import Foundation
import UIKit

class HistoryView: UIView {
    
    public var historyTable: UITableView = {
        let table = UITableView()
        table.backgroundColor = .white
        table.translatesAutoresizingMaskIntoConstraints = false
        table.register(SearchTableCell.self, forCellReuseIdentifier: SearchTableCell.identifier)
        return table
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
        addSubview(historyTable)
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            historyTable.leadingAnchor.constraint(equalTo: leadingAnchor),
            historyTable.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            historyTable.trailingAnchor.constraint(equalTo: trailingAnchor),
            historyTable.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
        ])
    }
}
