//
//  TopRatedShowItemCell.swift
//  UICollectionViewCompositionalLayoutShowTrackr
//
//  Created by abatjarg on 12/24/19.
//  Copyright © 2019 abatjarg. All rights reserved.
//

import UIKit

class TopRatedShowItemCell: UICollectionViewCell {
    static let reuseIdentifer = "top-rated-show-item-cell-reuse-identifier"

    let featuredPhotoView = UIImageView()

    var contentContainer: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.cornerRadius = 7
        view.layer.shadowOpacity = 0.5
        view.layer.shadowRadius = 4
        view.layer.shadowOffset = CGSize(width: 0, height: 2)
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

extension TopRatedShowItemCell {
    func configure() {
        contentContainer.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(featuredPhotoView)
        contentView.addSubview(contentContainer)
        
        featuredPhotoView.translatesAutoresizingMaskIntoConstraints = false
//        guard let featuredPhotoURL = self.featuredPhotoURL else { return };
//        let photo = UIImage(named: featuredPhotoURL)
//        featuredPhotoView.image = photo
        featuredPhotoView.layer.cornerRadius = 7
        featuredPhotoView.clipsToBounds = true
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
