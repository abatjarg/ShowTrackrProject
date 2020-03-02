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
                    self.shows = response.results
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

class SearchCollectionViewCell: UICollectionViewCell {
    
    let imageView = UIImageView()
    
    var contentContainer: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.cornerRadius = 7
        view.layer.shadowOpacity = 0.5
        view.layer.shadowRadius = 4
        view.layer.shadowOffset = CGSize(width: 0, height: 2)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    func configure() {
        contentContainer.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(imageView)
        contentView.addSubview(contentContainer)
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 7
        contentContainer.addSubview(imageView)

        
        NSLayoutConstraint.activate([
            contentContainer.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            contentContainer.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            contentContainer.topAnchor.constraint(equalTo: contentView.topAnchor),
            contentContainer.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            imageView.leadingAnchor.constraint(equalTo: contentContainer.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentContainer.trailingAnchor),
            imageView.topAnchor.constraint(equalTo: contentContainer.topAnchor),
            imageView.bottomAnchor.constraint(equalTo: contentContainer.bottomAnchor)
            
        ])
    }
    
}
