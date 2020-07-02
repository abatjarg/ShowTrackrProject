//
//  ShowDetailViewController.swift
//  ShowTrackr
//
//  Created by abatjarg on 3/1/20.
//  Copyright © 2020 abatjarg. All rights reserved.
//

import UIKit
import CoreData

class ShowDetailViewController: UIViewController {
    
    var item: ShowItem?
    
    var seasons = [ShowItem.ShowSeason]()
    var casts = [ShowItem.ShowCast]()
    
    var endpoint: Endpoint?
    let showService: ShowService = ShowItemStore.shared
    var shows = [ShowItem]()
    
    static let sectionHeaderElementKind = "show-detail-section-header-element-kind"
    static let sectionFooterElementKind = "show-detail-section-footer-element-kind"
    
    let showDetailCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let sdcv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        sdcv.showsVerticalScrollIndicator = false
        sdcv.translatesAutoresizingMaskIntoConstraints = false
        sdcv.register(ShowDetailHeaderView.self, forSupplementaryViewOfKind: ShowDetailViewController.sectionHeaderElementKind, withReuseIdentifier: ShowDetailHeaderView.reuseIdentifier)
        sdcv.register(ShowDetailFooterView.self, forSupplementaryViewOfKind: ShowDetailViewController.sectionFooterElementKind, withReuseIdentifier: ShowDetailFooterView.reuseIdentifier)
        sdcv.register(ShowDetailTrailerCollectionView.self, forCellWithReuseIdentifier: ShowDetailTrailerCollectionView.showDetailTrailerCellId)
        sdcv.register(ShowCastCollectionView.self, forCellWithReuseIdentifier: ShowCastCollectionView.showCastViewCellId)
        sdcv.register(ShowDetailRelatedCollectionView.self, forCellWithReuseIdentifier: ShowDetailRelatedCollectionView.showDetailRelatedViewCellId)
        sdcv.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        sdcv.backgroundColor = .white
        return sdcv
    }()

    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        navigationItem.title = item?.name
        //navigationItem.rightBarButtonItem = UIBarButtonItem(
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addBarButtonPressed))
        
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
    
    @objc func addBarButtonPressed() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Show", in: managedContext)!
        let show = NSManagedObject(entity: entity, insertInto: managedContext)
        
        show.setValue(item?.id, forKey: "id")

        do {
            try managedContext.save()
            let alertDisapperTimeInSeconds = 2.0
            let alert = UIAlertController(title: nil, message: "Show has been saved", preferredStyle: .actionSheet)
            self.present(alert, animated: true)
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + alertDisapperTimeInSeconds) {
              alert.dismiss(animated: true)
            }
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }

}

extension ShowDetailViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.row == 0 {
            let cell = showDetailCollectionView.dequeueReusableCell(withReuseIdentifier: ShowDetailTrailerCollectionView.showDetailTrailerCellId, for: indexPath) as! ShowDetailTrailerCollectionView
            cell.backgroundColor = .white
            cell.showId = item!.id
            return cell
        } else if indexPath.row == 1 {
            let cell = showDetailCollectionView.dequeueReusableCell(withReuseIdentifier: ShowCastCollectionView.showCastViewCellId, for: indexPath) as! ShowCastCollectionView
            cell.showId = item!.id
            return cell
        } else if indexPath.row == 2 {
            let cell = showDetailCollectionView.dequeueReusableCell(withReuseIdentifier: ShowDetailRelatedCollectionView.showDetailRelatedViewCellId, for: indexPath) as! ShowDetailRelatedCollectionView
            cell.showId = item!.id
            return cell
        } else {
            let cell = showDetailCollectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
            cell.backgroundColor = UIColor(red:0.97, green:0.97, blue:0.98, alpha:1.0)
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            let header = showDetailCollectionView.dequeueReusableSupplementaryView(ofKind: ShowDetailViewController.sectionHeaderElementKind, withReuseIdentifier: ShowDetailHeaderView.reuseIdentifier, for: indexPath) as! ShowDetailHeaderView
            header.featuredPhotoView.kf.setImage(with: item?.backdropURL)
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
            return .init(width: view.frame.width, height: 250)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return .init(width: view.frame.width, height: 400)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return .init(width: view.frame.width, height: 500)
    }
}
