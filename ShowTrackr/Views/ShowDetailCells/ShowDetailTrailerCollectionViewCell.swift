//
//  ShowDetailTrailerCollectionViewCell.swift
//  ShowTrackr
//
//  Created by abatjarg on 3/8/20.
//  Copyright © 2020 abatjarg. All rights reserved.
//

import UIKit

class ShowDetailTrailerCollectionViewCell: UICollectionViewCell {
    
    static let showDetailSeasonCellId = "show-detail-trailer-cell-id"
    
    var videoUrl: URL?
    
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
    
    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer)
    {
        let tappedImage = tapGestureRecognizer.view as! UIImageView
        
        UIApplication.shared.open(videoUrl!, options: [:], completionHandler: nil)

        print("Pressed")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(container)
        container.addSubview(imageContainer)
        imageContainer.addSubview(featuredPhotoView)
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        featuredPhotoView.isUserInteractionEnabled = true
        featuredPhotoView.addGestureRecognizer(tapGestureRecognizer)
        
        NSLayoutConstraint.activate([
            container.topAnchor.constraint(equalTo: topAnchor),
            container.leadingAnchor.constraint(equalTo: leadingAnchor),
            container.trailingAnchor.constraint(equalTo: trailingAnchor),
            container.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            imageContainer.topAnchor.constraint(equalTo: container.topAnchor),
            imageContainer.leadingAnchor.constraint(equalTo: container.leadingAnchor),
            imageContainer.trailingAnchor.constraint(equalTo: container.trailingAnchor),
            imageContainer.bottomAnchor.constraint(equalTo: container.bottomAnchor),
            
            featuredPhotoView.topAnchor.constraint(equalTo: imageContainer.topAnchor),
            featuredPhotoView.leadingAnchor.constraint(equalTo: imageContainer.leadingAnchor),
            featuredPhotoView.trailingAnchor.constraint(equalTo: imageContainer.trailingAnchor),
            featuredPhotoView.bottomAnchor.constraint(equalTo: imageContainer.bottomAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
