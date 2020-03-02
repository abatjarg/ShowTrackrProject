//
//  MainItemCell.swift
//  ShowTrackr
//
//  Created by abatjarg on 12/15/19.
//  Copyright © 2019 abatjarg. All rights reserved.
//

import UIKit

class MainItemCell: UICollectionViewCell {
    
    static let reuseIdentifer = "main-item-cell-reuse-identifier"
    
    override init(frame: CGRect) {
      super.init(frame: frame)
        backgroundColor = .red
    }

    required init?(coder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
    }
}
