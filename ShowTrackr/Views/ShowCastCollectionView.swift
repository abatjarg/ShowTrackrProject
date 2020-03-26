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
        
        addSubview(castCollectionView)
        
        castCollectionView.delegate = self
        castCollectionView.dataSource = self
        
        NSLayoutConstraint.activate([
            castCollectionView.topAnchor.constraint(equalTo: topAnchor),
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
