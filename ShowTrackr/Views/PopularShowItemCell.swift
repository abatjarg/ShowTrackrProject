//
//  PopularShowItemCell.swift
//  UICollectionViewCompositionalLayoutShowTrackr
//
//  Created by abatjarg on 12/22/19.
//  Copyright © 2019 abatjarg. All rights reserved.
//

import UIKit

class PopularShowItemCell: UICollectionViewCell {
    
    static let reuseIdentifer = "popular-show-item-cell-reuse-identifier"
    
    var featuredPhotoView: UIImageView = {
        let fpv = UIImageView()
        fpv.translatesAutoresizingMaskIntoConstraints = false
        fpv.layer.cornerRadius = 4
        fpv.clipsToBounds = true
        return fpv
    }()
    
    var contentContainer: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.cornerRadius = 4
        view.layer.shadowOpacity = 0.5
        view.layer.shadowRadius = 2
        view.layer.shadowOffset = CGSize(width: 0, height: 1)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var featuredPhotoURL: String? {
        didSet {
            configure()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension PopularShowItemCell {
    func configure() {
        
        contentView.addSubview(featuredPhotoView)
        contentView.addSubview(contentContainer)
        contentContainer.addSubview(featuredPhotoView)
        
        NSLayoutConstraint.activate([
            contentContainer.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            contentContainer.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            contentContainer.topAnchor.constraint(equalTo: contentView.topAnchor),
            contentContainer.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            featuredPhotoView.leadingAnchor.constraint(equalTo: contentContainer.leadingAnchor),
            featuredPhotoView.trailingAnchor.constraint(equalTo: contentContainer.trailingAnchor),
            featuredPhotoView.topAnchor.constraint(equalTo: contentContainer.topAnchor),
            featuredPhotoView.bottomAnchor.constraint(equalTo: contentContainer.bottomAnchor)
            
        ])
    }
}
