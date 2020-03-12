//
//  ShowDetailFooterView.swift
//  ShowTrackr
//
//  Created by abatjarg on 3/11/20.
//  Copyright © 2020 abatjarg. All rights reserved.
//

import UIKit

class ShowDetailFooterView: UICollectionReusableView {
    
    static let reuseIdentifier = "show-detail-footer-reuse-identifier"
    
    let sectionSeperator: UIView = {
        let seperator = UIView()
        seperator.translatesAutoresizingMaskIntoConstraints = false
        seperator.backgroundColor = UIColor(red:0.88, green:0.88, blue:0.88, alpha:1.0) //UIColor(red:0.94, green:0.94, blue:0.96, alpha:1.0)
        return seperator
    }()
    
    let containerView: UIView = {
        let cv = UIView()
        cv.translatesAutoresizingMaskIntoConstraints = false
        return cv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = UIColor(red:0.97, green:0.97, blue:0.98, alpha:1.0)
        
        addSubview(containerView)
        containerView.addSubview(sectionSeperator)
        
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: topAnchor),
            containerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            sectionSeperator.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 40),
            sectionSeperator.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            sectionSeperator.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20),
            sectionSeperator.heightAnchor.constraint(equalToConstant: 1.5),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
