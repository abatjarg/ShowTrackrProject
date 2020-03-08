//
//  ShowDetailTrailerCollectionView.swift
//  ShowTrackr
//
//  Created by abatjarg on 3/8/20.
//  Copyright © 2020 abatjarg. All rights reserved.
//

import UIKit

import UIKit

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
    
    var trailerCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let scv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        scv.translatesAutoresizingMaskIntoConstraints = false
        scv.backgroundColor = .white
        scv.register(ShowDetailTrailerCollectionViewCell.self, forCellWithReuseIdentifier: ShowDetailTrailerCollectionViewCell.showDetailSeasonCellId)
        return scv
    }()
    
    func fetchTrailers() {
        showService.fetchTrailers(id: showId, successHandler: { (response) in
            print("\(response)")
            self.trailers = response.results
            self.trailerCollectionView.reloadData()
        }) { (error) in
            print("\(error)")
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(trailerCollectionView)
        
        trailerCollectionView.delegate = self
        trailerCollectionView.dataSource = self
        
        NSLayoutConstraint.activate([
            trailerCollectionView.topAnchor.constraint(equalTo: topAnchor),
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
        print("\(trailers[indexPath.row].thumbnailUrl)")
        cell.featuredPhotoView.kf.setImage(with: trailers[indexPath.row].thumbnailUrl)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: frame.width - 50, height: 400)
    }
    
}
