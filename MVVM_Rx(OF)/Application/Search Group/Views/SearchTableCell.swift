//
//  SearchTableCell.swift
//  MVVM_Rx(OF)
//
//  Created by MacBook Air on 18.12.2021.
//
// TODO: add colors, text colors, star, arrow button
import UIKit

class SearchTableCell: UITableViewCell {
    
    // MARK: -  Identifier
    
    static let identifier = "SearchTableCell"
    
    // MARK: - Subviews
    
    let mainContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(named: K.Colors.myLightGray)
        view.layer.cornerRadius = 13
        return view
    }()
    
    let hStack: UIStackView = {
        let hStack = UIStackView()
        hStack.translatesAutoresizingMaskIntoConstraints = false
        hStack.axis = .horizontal
        hStack.layer.cornerRadius = 13
        hStack.distribution = .fill
        hStack.spacing = 16
        return hStack
    }()
    
    let vStack: UIStackView = {
        let vStack = UIStackView()
        vStack.translatesAutoresizingMaskIntoConstraints = false
        vStack.axis = .vertical
        vStack.spacing = 0
        vStack.distribution = .fill
        vStack.alignment = .leading
        return vStack
    }()
    
    let movieTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 17, weight: .semibold)
        return label
    }()
    
    let ratingLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.numberOfLines = 1
        label.textColor = UIColor(named: K.Colors.ratingGray)
        label.font = .systemFont(ofSize: 17, weight: .regular)
        return label
    }()
    
    let image: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.layer.cornerRadius = 10
        image.clipsToBounds = true
        image.backgroundColor = UIColor(named: K.Colors.starGray)
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    let starImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(systemName: "star")
        image.tintColor = UIColor(named: K.Colors.starGray)
        return image
    }()
    
    let arrowButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "chevron.right"), for: .normal)
        button.tintColor = UIColor(named: K.Colors.arrowGray)
        return button
    }()
    
    // MARK: - Inits
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(mainContainer)
        mainContainer.addSubview(hStack)
        setupHstack()
        setupvStack()
        setConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    // MARK: -  Layout methods
    
    private func setConstraints() {
        
        NSLayoutConstraint.activate([
            contentView.heightAnchor.constraint(greaterThanOrEqualToConstant: 100),
            
            mainContainer.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            mainContainer.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 9),
            mainContainer.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            mainContainer.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -9),
            
            hStack.leadingAnchor.constraint(equalTo: mainContainer.leadingAnchor, constant: 16),
            hStack.topAnchor.constraint(equalTo: mainContainer.topAnchor, constant: 16),
            hStack.trailingAnchor.constraint(equalTo: mainContainer.trailingAnchor, constant: -16),
            hStack.bottomAnchor.constraint(equalTo: mainContainer.bottomAnchor, constant: -16),
            
            vStack.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -2),
            
            image.heightAnchor.constraint(equalToConstant: 60),
            image.widthAnchor.constraint(equalToConstant: 60),
            
        ])
    }
    
    private func setupHstack() {
        hStack.addArrangedSubview(image)
        hStack.addArrangedSubview(vStack)
        hStack.addArrangedSubview(arrowButton)
    }
    
    private func setupvStack() {
        
        let hStack = UIStackView()
        hStack.axis = .horizontal
        hStack.spacing = 4
        
        hStack.addArrangedSubview(starImage)
        hStack.addArrangedSubview(ratingLabel)
        
        vStack.addArrangedSubview(movieTitleLabel)
        vStack.addArrangedSubview(hStack)
    }
}
