//
//  ShowDetailViewController.swift
//  ShowTrackr
//
//  Created by abatjarg on 3/1/20.
//  Copyright © 2020 abatjarg. All rights reserved.
//

import UIKit

class ShowDetailViewController: UIViewController {
    
    var item: ShowItem?
    
    var seasons = [ShowItem.ShowSeason]()
    
    var endpoint: Endpoint?
    let showService: ShowService = ShowItemStore.shared
    var shows = [ShowItem]()
    
    static let sectionHeaderElementKind = "show-detail-section-header-element-kind"
    static let sectionFooterElementKind = "show-detail-section-footer-element-kind"
    
    let showDetailCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let sdcv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        sdcv.translatesAutoresizingMaskIntoConstraints = false
        sdcv.register(ShowDetailHeaderView.self, forSupplementaryViewOfKind: ShowDetailViewController.sectionHeaderElementKind, withReuseIdentifier: ShowDetailHeaderView.reuseIdentifier)
        sdcv.register(ShowDetailFooterView.self, forSupplementaryViewOfKind: ShowDetailViewController.sectionFooterElementKind, withReuseIdentifier: ShowDetailFooterView.reuseIdentifier)
        sdcv.register(ShowDetailSeasonCollectionView.self, forCellWithReuseIdentifier: ShowDetailSeasonCollectionView.showDetailSeasonCellId)
        sdcv.register(ShowDetailTrailerCollectionView.self, forCellWithReuseIdentifier: ShowDetailTrailerCollectionView.showDetailTrailerCellId)
        sdcv.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        sdcv.backgroundColor = .white
        return sdcv
    }()

    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        navigationItem.title = item?.name
        
        view.addSubview(showDetailCollectionView)
        
        showDetailCollectionView.delegate = self
        showDetailCollectionView.dataSource = self
        
        NSLayoutConstraint.activate([
            showDetailCollectionView.topAnchor.constraint(equalTo: view.topAnchor),
            showDetailCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            showDetailCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            showDetailCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        fetchShow()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    fileprivate func fetchShow() {
        showService.fetchShow(id: item!.id, successHandler: { (response) in
            self.seasons = response.seasons!
            self.showDetailCollectionView.reloadData()
        }) { (error) in
            print("\(error)")
        }
    }

}

extension ShowDetailViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.row == 0 {
            let cell = showDetailCollectionView.dequeueReusableCell(withReuseIdentifier: ShowDetailSeasonCollectionView.showDetailSeasonCellId, for: indexPath) as! ShowDetailSeasonCollectionView
            cell.backgroundColor = UIColor(red:0.97, green:0.97, blue:0.98, alpha:1.0)
            cell.seasons = self.seasons
            //print("\(self.seasons)")
            return cell
        } else if indexPath.row == 1 {
            let cell = showDetailCollectionView.dequeueReusableCell(withReuseIdentifier: ShowDetailTrailerCollectionView.showDetailTrailerCellId, for: indexPath) as! ShowDetailTrailerCollectionView
            cell.backgroundColor = .white
            cell.showId = item!.id
            //print("\(self.seasons)")
            return cell
        } else {
            let cell = showDetailCollectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
            cell.backgroundColor = .white
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            let header = showDetailCollectionView.dequeueReusableSupplementaryView(ofKind: ShowDetailViewController.sectionHeaderElementKind, withReuseIdentifier: ShowDetailHeaderView.reuseIdentifier, for: indexPath) as! ShowDetailHeaderView
            header.featuredPhotoView.kf.setImage(with: item?.posterURL)
            header.overViewText.text = item?.overview
            return header
        case UICollectionView.elementKindSectionFooter:
            let footer = showDetailCollectionView.dequeueReusableSupplementaryView(ofKind: ShowDetailViewController.sectionFooterElementKind, withReuseIdentifier: ShowDetailFooterView.reuseIdentifier, for: indexPath) as! ShowDetailFooterView
            return footer
        default:
            assert(false, "Unexpected element kind")
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.row == 0 {
            return .init(width: view.frame.width, height: 400)
        } else if indexPath.row == 1 {
            return .init(width: view.frame.width, height: 400)
        } else {
            return .init(width: view.frame.width, height: 200)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return .init(width: view.frame.width, height: 250)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return .init(width: view.frame.width, height: 500)
    }
}
