//
//  ShowDetailSeasonCollectionView.swift
//  ShowTrackr
//
//  Created by abatjarg on 3/3/20.
//  Copyright © 2020 abatjarg. All rights reserved.
//

import UIKit

class ShowDetailSeasonCollectionView: UICollectionViewCell {
    
    static let showDetailSeasonCellId = "show-detail-season-view-cell-id"
    
    var seasons = [ShowItem.ShowSeason]() {
        didSet {
            seasonCollectionView.reloadData()
        }
    }
    
    var seasonCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let scv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        scv.translatesAutoresizingMaskIntoConstraints = false
        scv.register(ShowDetailSeasonCollectionViewCell.self, forCellWithReuseIdentifier: ShowDetailSeasonCollectionViewCell.showDetailSeasonCellId)
        scv.backgroundColor = UIColor(red:0.97, green:0.97, blue:0.98, alpha:1.0)
        return scv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(seasonCollectionView)
        
        seasonCollectionView.delegate = self
        seasonCollectionView.dataSource = self
        
        NSLayoutConstraint.activate([
            seasonCollectionView.topAnchor.constraint(equalTo: topAnchor),
            seasonCollectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            seasonCollectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            seasonCollectionView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ShowDetailSeasonCollectionView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return seasons.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = seasonCollectionView.dequeueReusableCell(withReuseIdentifier: ShowDetailSeasonCollectionViewCell.showDetailSeasonCellId, for: indexPath) as! ShowDetailSeasonCollectionViewCell
        cell.titleLabel.text = seasons[indexPath.row].name
        cell.overViewText.text = seasons[indexPath.row].overview
        cell.featuredPhotoView.kf.setImage(with: seasons[indexPath.row].posterURL)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: frame.width - 50, height: 400)
    }
    
}

