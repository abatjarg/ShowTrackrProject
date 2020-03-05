//
//  ViewAllCollectionViewCell.swift
//  ShowTrackr
//
//  Created by abatjarg on 3/2/20.
//  Copyright © 2020 abatjarg. All rights reserved.
//

import UIKit

class ViewAllCollectionViewCell: UICollectionViewCell {
    
    var featuredPhotoView: UIImageView = {
        let fpv = UIImageView()
        fpv.translatesAutoresizingMaskIntoConstraints = false
        fpv.layer.cornerRadius = 7
        fpv.clipsToBounds = true
        return fpv
    }()
    
    var container: UIView = {
        let view = UIView()
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.cornerRadius = 7
        view.layer.shadowOpacity = 0.5
        view.layer.shadowRadius = 4
        view.layer.shadowOffset = CGSize(width: 0, height: 2)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .lightGray
        return view
    }()
    
    var titleLabel: UILabel = {
        let tl = UILabel()
        tl.translatesAutoresizingMaskIntoConstraints = false
        return tl
    }()
    
    var overViewTextView: UITextView = {
        let ovtv = UITextView()
        ovtv.translatesAutoresizingMaskIntoConstraints = false
        return ovtv
    }()
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        addSubview(container)
        container.addSubview(featuredPhotoView)
        addSubview(titleLabel)
        addSubview(overViewTextView)
        
        NSLayoutConstraint.activate([
            container.topAnchor.constraint(equalTo:  topAnchor, constant: 20),
            container.leadingAnchor.constraint(equalTo:  leadingAnchor, constant: 20),
            container.trailingAnchor.constraint(equalTo:  trailingAnchor, constant: -20),
            container.heightAnchor.constraint(equalToConstant: 200),
            
            featuredPhotoView.leadingAnchor.constraint(equalTo: container.leadingAnchor),
            featuredPhotoView.trailingAnchor.constraint(equalTo: container.trailingAnchor),
            featuredPhotoView.topAnchor.constraint(equalTo: container.topAnchor),
            featuredPhotoView.bottomAnchor.constraint(equalTo: container.bottomAnchor),
            
            titleLabel.topAnchor.constraint(equalTo: container.bottomAnchor, constant: 10),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            titleLabel.heightAnchor.constraint(equalToConstant: 20),
            
            overViewTextView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor),
            overViewTextView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            overViewTextView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            overViewTextView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20)
        ])
        
        func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
            if traitCollection.userInterfaceStyle == .dark {
                backgroundColor = .black
            } else {
                backgroundColor = .white
            }
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
