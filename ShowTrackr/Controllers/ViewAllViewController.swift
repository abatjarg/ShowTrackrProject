//
//  ViewAllViewController.swift
//  ShowTrackr
//
//  Created by abatjarg on 3/1/20.
//  Copyright © 2020 abatjarg. All rights reserved.
//

import UIKit

class ViewAllViewController: UIViewController {
    
    var endpoint: Endpoint?
    let showService: ShowService = ShowItemStore.shared
    var shows = [ShowItem]()
    
    var fetchingData = false
    
    var page = 2
    
    let showsCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let scv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        scv.backgroundColor = .white
        scv.translatesAutoresizingMaskIntoConstraints = false
        scv.register(ViewAllCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        return scv
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.

        //view.backgroundColor = .white
        
        view.addSubview(showsCollectionView)
        
        showsCollectionView.delegate = self
        showsCollectionView.dataSource = self
        
        NSLayoutConstraint.activate([
            showsCollectionView.topAnchor.constraint(equalTo: view.topAnchor),
            showsCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            showsCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            showsCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        if traitCollection.userInterfaceStyle == .dark {
            view.backgroundColor = .black
            self.showsCollectionView.backgroundColor = .black
        } else {
            view.backgroundColor = .white
            self.showsCollectionView.backgroundColor = .white
        }
    }
}

extension ViewAllViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return shows.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = showsCollectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! ViewAllCollectionViewCell
        cell.featuredPhotoView.kf.setImage(with: self.shows[indexPath.row].backdropURL)
        cell.titleLabel.text = self.shows[indexPath.row].name
        cell.overViewTextView.text = self.shows[indexPath.row].overview
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.frame.width, height: 350)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        
        if offsetY > contentHeight - scrollView.frame.height {
            if !fetchingData {
                fetchData()
            }
        }
    }

    func fetchData() {
        showService.fetchShows(from: Endpoint.airingToday, params: ["page": String(page)], successHandler: {[unowned self] (response) in
            print("Total pages: \(response.totalPages)")
            self.shows.append(contentsOf: response.results)
            if self.page + 1 < response.totalPages {
                self.page += 1
                self.fetchingData = false
            }
            self.showsCollectionView.reloadData()
            }, errorHandler: {[unowned self] (error) in
                print("\(error.localizedDescription)")
        })
    }
}
