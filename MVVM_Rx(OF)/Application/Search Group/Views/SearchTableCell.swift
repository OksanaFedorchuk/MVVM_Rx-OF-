//
//  SearchTableCell.swift
//  MVVM_Rx(OF)
//
//  Created by MacBook Air on 18.12.2021.
//

import UIKit

class SearchTableCell: UITableViewCell {
    
    // MARK: -  Properties
    
    static let identifier = K.Identifier.searchTableCell
    
    let container: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .lightGray
        return view
    }()
    
    let secondTeamLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 18, weight: .semibold)
        return label
    }()
    
    let image: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.layer.cornerRadius = 10
        return image
    }()
    
    // MARK: - Inits
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(container)
        container.addSubview(image)
        container.addSubview(secondTeamLabel)
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
            container.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            container.topAnchor.constraint(equalTo: contentView.topAnchor),
            container.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            container.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            image.heightAnchor.constraint(equalToConstant: 60),
            image.widthAnchor.constraint(equalToConstant: 60),
            image.leadingAnchor.constraint(equalTo: container.leadingAnchor),
            image.topAnchor.constraint(equalTo: container.topAnchor),
            image.trailingAnchor.constraint(equalTo: container.trailingAnchor),
            image.bottomAnchor.constraint(equalTo: secondTeamLabel.topAnchor),
            
            secondTeamLabel.leadingAnchor.constraint(equalTo: container.leadingAnchor),
            secondTeamLabel.heightAnchor.constraint(equalToConstant: 50),
            secondTeamLabel.trailingAnchor.constraint(equalTo: container.trailingAnchor),
            secondTeamLabel.bottomAnchor.constraint(equalTo: container.bottomAnchor),
        ])
    }
}
