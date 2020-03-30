//
//  ShowDetailSeasonCollectionViewCell.swift
//  ShowTrackr
//
//  Created by abatjarg on 3/3/20.
//  Copyright © 2020 abatjarg. All rights reserved.
//

import UIKit

class ShowDetailSeasonCollectionViewCell: UICollectionViewCell {
    
    static let showDetailSeasonCellId = "show-detail-season-cell-id"
    
    var container: UIView = {
        let container = UIView()
        container.translatesAutoresizingMaskIntoConstraints = false
        container.backgroundColor = UIColor(red:0.97, green:0.97, blue:0.98, alpha:1.0)
        return container
    }()
    
    var imageContainer: UIView = {
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
    
    var featuredPhotoView: UIImageView = {
        let fpv = UIImageView()
        fpv.translatesAutoresizingMaskIntoConstraints = false
        fpv.layer.cornerRadius = 7
        fpv.clipsToBounds = true
        return fpv
    }()
    
    var titleLabel: UILabel = {
        let tl = UILabel()
        tl.translatesAutoresizingMaskIntoConstraints = false
        return tl
    }()
    
    var overViewText: UITextView = {
        let ovt = UITextView()
        ovt.translatesAutoresizingMaskIntoConstraints = false
        ovt.backgroundColor = UIColor(red:0.97, green:0.97, blue:0.98, alpha:1.0)
        return ovt
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(container)
        container.addSubview(imageContainer)
        imageContainer.addSubview(featuredPhotoView)
        container.addSubview(titleLabel)
        container.addSubview(overViewText)
        
        NSLayoutConstraint.activate([
            container.topAnchor.constraint(equalTo: topAnchor),
            container.leadingAnchor.constraint(equalTo: leadingAnchor),
            container.trailingAnchor.constraint(equalTo: trailingAnchor),
            container.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            imageContainer.topAnchor.constraint(equalTo: container.topAnchor),
            imageContainer.bottomAnchor.constraint(equalTo: container.bottomAnchor),
            imageContainer.leadingAnchor.constraint(equalTo: container.leadingAnchor),
            imageContainer.widthAnchor.constraint(equalTo: imageContainer.heightAnchor, multiplier: 3/5),
            
            featuredPhotoView.topAnchor.constraint(equalTo: imageContainer.topAnchor),
            featuredPhotoView.leadingAnchor.constraint(equalTo: imageContainer.leadingAnchor),
            featuredPhotoView.trailingAnchor.constraint(equalTo: imageContainer.trailingAnchor),
            featuredPhotoView.bottomAnchor.constraint(equalTo: imageContainer.bottomAnchor),
            
            titleLabel.topAnchor.constraint(equalTo: container.topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: imageContainer.trailingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: container.trailingAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: container.bottomAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
