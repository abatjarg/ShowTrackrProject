//
//  ShowDetailRelatedCollectionView.swift
//  ShowTrackr
//
//  Created by abatjarg on 3/25/20.
//  Copyright © 2020 abatjarg. All rights reserved.
//

import UIKit
import Kingfisher

class ShowDetailRelatedCollectionView: UICollectionViewCell {
    
    static let showDetailRelatedViewCellId = "show-related-view-cell-id"
    
    var endpoint: Endpoint?
    let showService: ShowService = ShowItemStore.shared
    var relatedShows = [ShowItem]()
    
    var showId = Int() {
        didSet {
            fetchRelatedShows()
        }
    }
    
    let sectionLabel: UILabel = {
        let sl = UILabel()
        sl.translatesAutoresizingMaskIntoConstraints = false
        sl.adjustsFontForContentSizeCategory = true
        sl.font = UIFont.preferredFont(forTextStyle: .title3)
        sl.text = "Related"
        return sl
    }()
    
    let sectionSeperator: UIView = {
        let seperator = UIView()
        seperator.translatesAutoresizingMaskIntoConstraints = false
        seperator.backgroundColor = UIColor(red:0.94, green:0.94, blue:0.96, alpha:1.0)
        return seperator
    }()
    
    var relatedCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let ccv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        ccv.showsHorizontalScrollIndicator = false
        ccv.translatesAutoresizingMaskIntoConstraints = false
        ccv.backgroundColor = .white
        ccv.register(ShowDetailRelatedCollectionViewCell.self, forCellWithReuseIdentifier: ShowDetailRelatedCollectionViewCell.showDetailRelatedViewCellCellId)
        return ccv
    }()
    
    func fetchRelatedShows() {
        showService.fetchRelated(id: showId, successHandler: { (response) in
            self.relatedShows = response.results
            self.relatedCollectionView.reloadData()
            //print("\(self.relatedShows)")
        }) { (error) in
            print("\(error)")
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        addSubview(sectionSeperator)
        addSubview(sectionLabel)
        addSubview(relatedCollectionView)

        relatedCollectionView.delegate = self
        relatedCollectionView.dataSource = self

        NSLayoutConstraint.activate([
            
            sectionSeperator.topAnchor.constraint(equalTo: topAnchor),
            sectionSeperator.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            sectionSeperator.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            sectionSeperator.heightAnchor.constraint(equalToConstant: 1.5),
            
            sectionLabel.topAnchor.constraint(equalTo: sectionSeperator.bottomAnchor, constant: 15),
            sectionLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            sectionLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            sectionLabel.heightAnchor.constraint(equalToConstant: 15),
            
            relatedCollectionView.topAnchor.constraint(equalTo: sectionLabel.bottomAnchor),
            relatedCollectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            relatedCollectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            relatedCollectionView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ShowDetailRelatedCollectionView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return relatedShows.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = relatedCollectionView.dequeueReusableCell(withReuseIdentifier: ShowDetailRelatedCollectionViewCell.showDetailRelatedViewCellCellId, for: indexPath) as! ShowDetailRelatedCollectionViewCell
        cell.featuredPhotoView.kf.setImage(with: relatedShows[indexPath.row].backdropURL)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: frame.width - 50, height: 200)
    }
    
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        print("\(relatedShows[indexPath.row].name)")
//    }
    
}
