//
//  DetailsView.swift
//  MVVM_Rx(OF)
//
//  Created by MacBook Air on 21.12.2021.
//

import Foundation
import UIKit

class DetailsView: UIView {
    
    
    // MARK: - Main containers
    
    private let topContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(named: K.Colors.myLightGray)
        return view
    }()
    
    private let bottomContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        return view
    }()
    
    
    // MARK: - Top container subviews
    
    private let image: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.backgroundColor = UIColor(named: K.Colors.starGray)
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    private let topStack: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.distribution = .fill
        stack.alignment = .leading
        stack.spacing = 10
        return stack
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 28, weight: .bold)
        label.textAlignment = .left
        label.numberOfLines = 1
        label.textColor = .white
        label.text = "Mock Movie label Text"
        label.shadowColor = .black
        label.shadowOffset = CGSize(width: 0.3, height: 0.3)
        return label
    }()
    
    let ratingLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.numberOfLines = 1
        label.textColor = .white
        label.text = "7.8"
        label.font = .systemFont(ofSize: 13, weight: .regular)
        label.alpha = 0.5
        label.shadowColor = .darkGray
        label.shadowOffset = CGSize(width: 0.3, height: 0.3)
        return label
    }()
    
    private let starImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(named: K.Icons.starIcon)
        return image
    }()
    
    
    // MARK: - Bottom container subviews
    
    private let bottomStack: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.distribution = .fillProportionally
        stack.alignment = .leading
        stack.spacing = 10
        return stack
    }()
    
    private let overviewLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 13, weight: .regular)
        label.textAlignment = .left
        label.numberOfLines = 6
        label.textColor = UIColor(named: K.Colors.ratingGray)
        label.text = "This is the overview to the movie selected by user. May be long, yeah"
        return label
    }()
    
    private let viewOnlineButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = UIColor(named: K.Colors.lightGrayDetails)
        button.layer.cornerRadius = 17
        
        let titleAttributes = [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 17, weight: .semibold)]
        let attributedString = NSMutableAttributedString(string: "VIEW ONLINE", attributes: titleAttributes)
        button.setAttributedTitle(attributedString, for: .normal)
        
        button.contentEdgeInsets = UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 10)
        button.setTitleColor(UIColor(named: K.Colors.brightBlue), for: .normal)
        return button
    }()
    
    public var detailsTable: UITableView = {
        let table = UITableView()
        table.backgroundColor = .white
        table.translatesAutoresizingMaskIntoConstraints = false
        table.register(DetailsTableCell.self, forCellReuseIdentifier: DetailsTableCell.identifier)
        return table
    }()
    
    private let shareButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = UIColor(named: K.Colors.lightGrayDetails)
        button.layer.cornerRadius = 10
        button.setImage(UIImage(named: "shareIcon"), for: .normal)
        
        let titleAttributes = [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 17, weight: .semibold)]
        let attributedString = NSMutableAttributedString(string: "  Share Movie", attributes: titleAttributes)
        button.setAttributedTitle(attributedString, for: .normal)
        button.setTitleColor(UIColor(named: K.Colors.brightBlue), for: .normal)
        return button
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
    
    
    // MARK: - Layout methods
    
    private func addSubviews() {
        addSubview(topContainer)
        addSubview(bottomContainer)
        topContainer.addSubview(topStack)
        bottomContainer.addSubview(bottomStack)
        bottomContainer.addSubview(detailsTable)
        bottomContainer.addSubview(shareButton)
        
        setupTopStack()
        setupBottomStack()
    }
    
    private func setupTopStack() {
        let hStack = UIStackView()
        hStack.axis = .horizontal
        hStack.spacing = 4
        
        hStack.addArrangedSubview(starImage)
        hStack.addArrangedSubview(ratingLabel)
        
        topStack.addArrangedSubview(titleLabel)
        topStack.addArrangedSubview(hStack)
    }
    
    private func setupBottomStack() {
        let hStack = UIStackView()
        hStack.axis = .horizontal
        hStack.spacing = 4
        
        hStack.addArrangedSubview(overviewLabel)
        hStack.addArrangedSubview(viewOnlineButton)
        
        bottomStack.addArrangedSubview(hStack)
    }
    
    
    // MARK: - Constraints
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            
            // top container containing header with image
            topContainer.leadingAnchor.constraint(equalTo: leadingAnchor),
            topContainer.topAnchor.constraint(equalTo: topAnchor),
            topContainer.trailingAnchor.constraint(equalTo: trailingAnchor),
            topContainer.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.3),
            
            // stack containing titleLabel, starImage and ratingLabel
            topStack.leadingAnchor.constraint(equalTo: topContainer.leadingAnchor, constant: 20),
            topStack.bottomAnchor.constraint(equalTo: topContainer.bottomAnchor, constant: -22),
            topStack.trailingAnchor.constraint(equalTo: topContainer.trailingAnchor, constant: -20),
            
            starImage.heightAnchor.constraint(equalToConstant: 13),
            starImage.widthAnchor.constraint(equalToConstant: 13),
            
            // bottom container containing table and share button
            bottomContainer.leadingAnchor.constraint(equalTo: leadingAnchor),
            bottomContainer.topAnchor.constraint(equalTo: topContainer.bottomAnchor),
            bottomContainer.trailingAnchor.constraint(equalTo: trailingAnchor),
            bottomContainer.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            
            // stack containing overviewLabel and viewOnlineButton
            bottomStack.leadingAnchor.constraint(equalTo: bottomContainer.leadingAnchor, constant: 20),
            bottomStack.topAnchor.constraint(equalTo: bottomContainer.topAnchor, constant: 21),
            bottomStack.trailingAnchor.constraint(equalTo: bottomContainer.trailingAnchor, constant: -20),
            bottomStack.heightAnchor.constraint(equalToConstant: 200),
            
            viewOnlineButton.widthAnchor.constraint(greaterThanOrEqualToConstant: 120),
            viewOnlineButton.heightAnchor.constraint(greaterThanOrEqualToConstant: 30),
            
            
            // table
            detailsTable.leadingAnchor.constraint(equalTo: bottomContainer.leadingAnchor, constant: 20),
            detailsTable.topAnchor.constraint(equalTo: bottomStack.bottomAnchor),
            detailsTable.trailingAnchor.constraint(equalTo: bottomContainer.trailingAnchor, constant: -20),
            detailsTable.bottomAnchor.constraint(equalTo: shareButton.topAnchor, constant: 20),
            
            //share button
            shareButton.leadingAnchor.constraint(equalTo: bottomContainer.leadingAnchor, constant: 20),
            shareButton.heightAnchor.constraint(equalToConstant: 50),
            shareButton.trailingAnchor.constraint(equalTo: bottomContainer.trailingAnchor, constant: -20),
            shareButton.bottomAnchor.constraint(equalTo: shareButton.topAnchor, constant: 20)
        ])
    }
}
