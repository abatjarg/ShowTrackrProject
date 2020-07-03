//
//  ShowDetailHeaderView.swift
//  ShowTrackr
//
//  Created by abatjarg on 3/3/20.
//  Copyright © 2020 abatjarg. All rights reserved.
//

import UIKit

class ShowDetailHeaderView: UICollectionReusableView {
    
    static let reuseIdentifier = "show-detail-header-reuse-identifier"
    
    var item: ShowItem?
    
    let sectionSeperator: UIView = {
        let seperator = UIView()
        seperator.translatesAutoresizingMaskIntoConstraints = false
        seperator.backgroundColor = UIColor(red:0.94, green:0.94, blue:0.96, alpha:1.0)
        return seperator
    }()
    
    let containerView: UIView = {
        let cv = UIView()
        cv.translatesAutoresizingMaskIntoConstraints = false
        return cv
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
        tl.text = "RIverdale"
        return tl
    }()
    
    var overViewText: UITextView = {
        let ovt = UITextView()
        ovt.translatesAutoresizingMaskIntoConstraints = false
        return ovt
    }()
    
    var overViewInfoText: UITextView = {
        let ovft = UITextView()
        ovft.translatesAutoresizingMaskIntoConstraints = false
        return ovft
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .white
        
        addSubview(sectionSeperator)
        addSubview(containerView)

        
        containerView.addSubview(imageContainer)
        containerView.addSubview(overViewText)
        imageContainer.addSubview(featuredPhotoView)
        
        //featuredPhotoView.kf.setImage(with: item?.posterURL)
        
        NSLayoutConstraint.activate([
            sectionSeperator.topAnchor.constraint(equalTo: topAnchor),
            sectionSeperator.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            sectionSeperator.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            sectionSeperator.heightAnchor.constraint(equalToConstant: 1.5),
            
            containerView.topAnchor.constraint(equalTo: sectionSeperator.topAnchor, constant: 20),
            containerView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            containerView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            containerView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20),
            
            imageContainer.topAnchor.constraint(equalTo: containerView.topAnchor),
            imageContainer.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            imageContainer.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            imageContainer.heightAnchor.constraint(equalToConstant: 200),
            
            overViewText.topAnchor.constraint(equalTo: imageContainer.bottomAnchor, constant: 20),
            overViewText.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            overViewText.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            overViewText.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            
            featuredPhotoView.topAnchor.constraint(equalTo: imageContainer.topAnchor),
            featuredPhotoView.leadingAnchor.constraint(equalTo: imageContainer.leadingAnchor),
            featuredPhotoView.trailingAnchor.constraint(equalTo: imageContainer.trailingAnchor),
            featuredPhotoView.bottomAnchor.constraint(equalTo: imageContainer.bottomAnchor),
        ])
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
