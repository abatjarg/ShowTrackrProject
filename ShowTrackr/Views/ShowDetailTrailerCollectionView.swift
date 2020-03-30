//
//  ShowDetailTrailerCollectionView.swift
//  ShowTrackr
//
//  Created by abatjarg on 3/8/20.
//  Copyright © 2020 abatjarg. All rights reserved.
//

import UIKit

import UIKit
import Kingfisher

class ShowDetailTrailerCollectionView: UICollectionViewCell {
    
    static let showDetailTrailerCellId = "show-detail-trailer-view-cell-id"
    
    var endpoint: Endpoint?
    let showService: ShowService = ShowItemStore.shared
    var trailers = [ShowItem.ShowVideo]()
    
    var showId = Int() {
        didSet {
            fetchTrailers()
        }
    }
    
    let sectionLabel: UILabel = {
        let sl = UILabel()
        sl.translatesAutoresizingMaskIntoConstraints = false
        sl.adjustsFontForContentSizeCategory = true
        sl.font = UIFont.preferredFont(forTextStyle: .title3)
        sl.text = "Trailer"
        return sl
    }()
    
    let sectionSeperator: UIView = {
        let seperator = UIView()
        seperator.translatesAutoresizingMaskIntoConstraints = false
        seperator.backgroundColor = UIColor(red:0.94, green:0.94, blue:0.96, alpha:1.0)
        return seperator
    }()
    
    var trailerCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.sectionInset = .init(top: 10, left: 20, bottom: 10, right: 20)
        let scv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        scv.translatesAutoresizingMaskIntoConstraints = false
        scv.showsHorizontalScrollIndicator = false
        scv.backgroundColor = .white
        scv.register(ShowDetailTrailerCollectionViewCell.self, forCellWithReuseIdentifier: ShowDetailTrailerCollectionViewCell.showDetailSeasonCellId)
        return scv
    }()
    
    func fetchTrailers() {
        showService.fetchTrailers(id: showId, successHandler: { (response) in
            self.trailers = response.results
            self.trailerCollectionView.reloadData()
        }) { (error) in
            print("\(error)")
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(sectionSeperator)
        addSubview(sectionLabel)
        addSubview(trailerCollectionView)
        
        trailerCollectionView.delegate = self
        trailerCollectionView.dataSource = self
        
        NSLayoutConstraint.activate([
            sectionSeperator.topAnchor.constraint(equalTo: topAnchor),
            sectionSeperator.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            sectionSeperator.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            sectionSeperator.heightAnchor.constraint(equalToConstant: 1.5),
            
            sectionLabel.topAnchor.constraint(equalTo: sectionSeperator.bottomAnchor, constant: 15),
            sectionLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            sectionLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            sectionLabel.heightAnchor.constraint(equalToConstant: 15),
            
            trailerCollectionView.topAnchor.constraint(equalTo: sectionLabel.bottomAnchor),
            trailerCollectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            trailerCollectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            trailerCollectionView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension ShowDetailTrailerCollectionView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return trailers.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = trailerCollectionView.dequeueReusableCell(withReuseIdentifier: ShowDetailTrailerCollectionViewCell.showDetailSeasonCellId, for: indexPath) as! ShowDetailTrailerCollectionViewCell
        cell.featuredPhotoView.kf.setImage(with: trailers[indexPath.row].thumbnailUrl)
        cell.videoUrl = trailers[indexPath.row].youtubeURL
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: frame.width - 50, height: 200)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
}
