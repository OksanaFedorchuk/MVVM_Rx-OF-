//
//  DynamicHeightTable.swift
//  MVVM_Rx(OF)
//
//  Created by Oksana Fedorchuk on 11.04.2022.
//

import UIKit

class DynamicHeightTable: UITableView {
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if !__CGSizeEqualToSize(bounds.size, self.intrinsicContentSize) {
            self.invalidateIntrinsicContentSize()
        }
    }
    
    override var intrinsicContentSize: CGSize {
        return contentSize
    }
}
