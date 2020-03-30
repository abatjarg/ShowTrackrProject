//
//  ShowCastCollectionView.swift
//  ShowTrackr
//
//  Created by abatjarg on 3/23/20.
//  Copyright © 2020 abatjarg. All rights reserved.
//

import UIKit
import Kingfisher

class ShowCastCollectionView: UICollectionViewCell {
    
    static let showCastViewCellId = "show-cast-view-cell-id"
    
    var endpoint: Endpoint?
    let showService: ShowService = ShowItemStore.shared
    var cast = [ShowItem.ShowCast]()
    
    var showId = Int() {
        didSet {
            fetchCast()
        }
    }
    
    let sectionLabel: UILabel = {
        let sl = UILabel()
        sl.translatesAutoresizingMaskIntoConstraints = false
        sl.adjustsFontForContentSizeCategory = true
        sl.font = UIFont.preferredFont(forTextStyle: .title3)
        sl.text = "Cast"
        return sl
    }()
    
    let sectionSeperator: UIView = {
        let seperator = UIView()
        seperator.translatesAutoresizingMaskIntoConstraints = false
        seperator.backgroundColor = UIColor(red:0.94, green:0.94, blue:0.96, alpha:1.0)
        return seperator
    }()
    
    var castCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let ccv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        ccv.showsHorizontalScrollIndicator = false
        ccv.translatesAutoresizingMaskIntoConstraints = false
        ccv.backgroundColor = .white
        ccv.register(ShowCastCollectionViewCell.self, forCellWithReuseIdentifier: ShowCastCollectionViewCell.showCastCellId)
        return ccv
    }()
    
    func fetchCast() {
        showService.fetchCast(id: showId, successHandler: { (response) in
            self.cast = response.cast
            self.castCollectionView.reloadData()
        }) { (error) in
            print("\(error)")
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(sectionSeperator)
        addSubview(sectionLabel)
        addSubview(castCollectionView)
        
        castCollectionView.delegate = self
        castCollectionView.dataSource = self
        
        NSLayoutConstraint.activate([
            
            sectionSeperator.topAnchor.constraint(equalTo: topAnchor),
            sectionSeperator.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            sectionSeperator.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            sectionSeperator.heightAnchor.constraint(equalToConstant: 1.5),
            
            sectionLabel.topAnchor.constraint(equalTo: sectionSeperator.bottomAnchor, constant: 15),
            sectionLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            sectionLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            sectionLabel.heightAnchor.constraint(equalToConstant: 15),
            
            castCollectionView.topAnchor.constraint(equalTo: sectionLabel.bottomAnchor),
            castCollectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            castCollectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            castCollectionView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension ShowCastCollectionView: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cast.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = castCollectionView.dequeueReusableCell(withReuseIdentifier: ShowCastCollectionViewCell.showCastCellId, for: indexPath) as! ShowCastCollectionViewCell
        cell.featuredPhotoView.kf.setImage(with: cast[indexPath.row].profileURL)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: frame.width/3, height: 200)
    }
    
}
