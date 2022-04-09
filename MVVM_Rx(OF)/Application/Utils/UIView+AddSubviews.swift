//
//  UIView+AddSubviews.swift
//  MVVM_Rx(OF)
//
//  Created by Oksana Fedorchuk on 17.02.2022.
//

import UIKit

extension UIView {
    
    func addSubviews(_ subviews: [UIView]) {
        subviews.forEach { addSubview($0) }
    }
}

extension UIStackView {
    
    func addArrangedSubviews(_ views: [UIView]) {
        views.forEach { addArrangedSubview($0) }
    }
}
