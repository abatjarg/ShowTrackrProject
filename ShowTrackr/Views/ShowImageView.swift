//
//  ShowImageView.swift
//  ShowTrackr
//
//  Created by abatjarg on 3/10/20.
//  Copyright © 2020 abatjarg. All rights reserved.
//

import UIKit

class ShowImageView: UIView {
    
    var imageContainer: UIView = {
        let ic = UIView()
        ic.backgroundColor = UIColor.white
        ic.layer.shadowColor = UIColor.black.cgColor
        ic.layer.cornerRadius = 7
        ic.layer.shadowOpacity = 0.5
        ic.layer.shadowRadius = 4
        ic.layer.shadowOffset = CGSize(width: 0, height: 2)
        ic.translatesAutoresizingMaskIntoConstraints = false
        return ic
    }()
    
    var imageView: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.layer.cornerRadius = 7
        iv.clipsToBounds = true
        return iv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(imageContainer)
        imageContainer.addSubview(imageView)
        
        NSLayoutConstraint.activate([
            imageContainer.topAnchor.constraint(equalTo: topAnchor),
            imageContainer.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageContainer.trailingAnchor.constraint(equalTo: trailingAnchor),
            imageContainer.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            imageView.topAnchor.constraint(equalTo: imageContainer.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: imageContainer.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: imageContainer.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: imageContainer.bottomAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
