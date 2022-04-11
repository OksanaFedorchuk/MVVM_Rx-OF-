//
//  DetailsTableCell.swift
//  MVVM_Rx(OF)
//
//  Created by Oksana Fedorchuk on 09.04.2022.
//

import UIKit

class DetailsTableCell: UITableViewCell {
    
    
    // MARK: -  Identifier
    
    static let identifier = "DetailsTableCell"
    
    // MARK: - Subviews
    
    private let hStack: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.distribution = .fillProportionally
        return stack
    }()
    
    private let container: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        return view
    }()
    
    let image: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.layer.cornerRadius = 18
        image.clipsToBounds = true
        image.backgroundColor = UIColor(named: K.Colors.starGray)
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    private let vStack: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.distribution = .fill
        stack.alignment = .leading
        return stack
    }()
    
    private let authorNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 13, weight: .semibold)
        label.textAlignment = .left
        label.numberOfLines = 1
        label.textColor = UIColor(named: K.Colors.brightBlue)
        label.text = "AUTHOR NAME"
        return label
    }()
    
    private let creationDateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 17, weight: .regular)
        label.textAlignment = .left
        label.numberOfLines = 1
        label.textColor = .black
        label.text = "24.02.2022"
        return label
    }()
    
    private let contentLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 17, weight: .regular)
        label.textAlignment = .left
        label.numberOfLines = 2
        label.textColor = UIColor(named: K.Colors.ratingGray)
        label.text = "You might notice some of the system snippets have a placeholder token where you can navigate and input a missing token. For example, if let snippet"
        return label
    }()
    
    // MARK: - Inits
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(hStack)
        container.addSubview(image)
        setupHstack()
        setupVstack()
        setConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    // MARK: - Layout methods
    
    private func setupHstack() {
        
        hStack.addArrangedSubviews([container, vStack])
        
    }
    
    private func setupVstack() {
        vStack.addArrangedSubviews([authorNameLabel, creationDateLabel, contentLabel])
    }
    
    // MARK: - Constraints
    
    private func setConstraints() {
        
        NSLayoutConstraint.activate([
            contentView.heightAnchor.constraint(greaterThanOrEqualToConstant: 110),
            
            hStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            hStack.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 9),
            hStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            hStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -9),
            
            container.widthAnchor.constraint(equalToConstant: 45),
            
            image.heightAnchor.constraint(equalToConstant: 36),
            image.widthAnchor.constraint(equalToConstant: 36),
            image.centerXAnchor.constraint(equalTo: container.centerXAnchor),
            image.centerYAnchor.constraint(equalTo: container.centerYAnchor)
        ])
    }
    
    func configure(with company: ProductionCompany) {
        authorNameLabel.text = company.name
        contentLabel.text = company.originCountry
    }
}
