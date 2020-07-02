//
//  SearchViewController.swift
//  ShowTrackr
//
//  Created by abatjarg on 3/1/20.
//  Copyright © 2020 abatjarg. All rights reserved.
//

import UIKit
import Combine

class SearchViewController: UIViewController {
    
    var endpoint: Endpoint?
    let showService: ShowService = ShowItemStore.shared
    var shows = [ShowItem]()
    
    fileprivate let searchCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.backgroundColor = .white
        cv.register(SearchCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        return cv
    }()
    
    let searchController = UISearchController(searchResultsController: nil)
    
    private var cancellableBag = Set<AnyCancellable>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupSearchBarListener()
        
        navigationItem.searchController = searchController
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Search"
        
        searchController.obscuresBackgroundDuringPresentation = false
        
        view.backgroundColor = .white
        
        searchCollectionView.delegate = self
        searchCollectionView.dataSource = self
        
        view.addSubview(searchCollectionView)
        searchCollectionView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        searchCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        searchCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        searchCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    }
    
    fileprivate func setupSearchBarListener() {
        
        let publisher = NotificationCenter.default.publisher(for: UISearchTextField.textDidChangeNotification, object: searchController.searchBar.searchTextField)
        publisher
            .map {
            ($0.object as! UISearchTextField).text
        }
            .debounce(for: .milliseconds(500), scheduler: RunLoop.main)
            .removeDuplicates()
            .sink { (str) in
                self.showService.searchShows(query: str ?? "", params: nil, successHandler: {[unowned self] (response) in
                    self.shows.removeAll()
                    for result in response.results {
                        if (result.posterURL != nil) {
                            self.shows.append(result)
                        }
                    }
                    print("Result length: \(response.results.count)")
                    self.searchCollectionView.reloadData()
                    }, errorHandler: {[unowned self] (error) in
                        print("\(error.localizedDescription)")
                })
        }
        .store(in: &cancellableBag)
    }
}

extension SearchViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width/2 - 10, height: (collectionView.frame.width/4)*3)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.shows.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! SearchCollectionViewCell
        if let posterUrl = self.shows[indexPath.row].posterURL {
            cell.imageView.kf.setImage(with: posterUrl)
        } 
        return cell
    }
    
//    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        self.searchController.searchBar.resignFirstResponder()
//    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let showDetailVC = ShowDetailViewController()
        showDetailVC.item = self.shows[indexPath.row]
        navigationController?.pushViewController(showDetailVC, animated: true)
    }
}
