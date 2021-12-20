//
//  SearchTableCell.swift
//  MVVM_Rx(OF)
//
//  Created by MacBook Air on 18.12.2021.
//

import UIKit

class SearchTableCell: UITableViewCell {
    
    // MARK: -  Properties
    
    static let identifier = "SearchTableCell"
    
    let secondTeamLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 18, weight: .semibold)
        return label
    }()
    
    // MARK: - Inits
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(secondTeamLabel)
        
        setConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    // MARK: -  Private methods
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            contentView.heightAnchor.constraint(greaterThanOrEqualToConstant: 50),
            secondTeamLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            secondTeamLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            secondTeamLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            secondTeamLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])
    }
}
