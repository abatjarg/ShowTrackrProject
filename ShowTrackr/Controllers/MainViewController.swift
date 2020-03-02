//
//  ViewController.swift
//  UICollectionViewCompositionalLayoutShowTrackr
//
//  Created by abatjarg on 12/21/19.
//  Copyright © 2019 abatjarg. All rights reserved.
//

import UIKit
import Kingfisher

class MainViewController: UIViewController {
    
    var endpoint: Endpoint?
    let showService: ShowService = ShowItemStore.shared
    var shows = [ShowItem]()
    
    var featuredShows = [ShowItem]()
    var popularShows = [ShowItem]()
    var topRatedShows = [ShowItem]()
    
    static let sectionHeaderElementKind = "section-header-element-kind"

    enum Section: String, CaseIterable {
        case featuredMovies = "Airing Today"
        case popularShows = "Popular Shows"
        case topRatedShows = "Top Rated Shows"
    }

    var dataSource: UICollectionViewDiffableDataSource<Section, ShowItem>! = nil
    var mainCollectionView: UICollectionView! = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "ShowTrackr"
        configureCollectionView()
        fetchShows()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        mainCollectionView.collectionViewLayout.invalidateLayout()
    }
    
}

extension MainViewController {
    
    func fetchShows() {
            
        let group = DispatchGroup()
        
        group.enter()
        showService.fetchShows(from: Endpoint.airingToday, params: nil, successHandler: {[unowned self] (response) in
            self.featuredShows = response.results
            print("\(response.results.count)")
            group.leave()
            }, errorHandler: {[unowned self] (error) in
                group.leave()
                print("\(error.localizedDescription)")
        })
        
        group.enter()
        showService.fetchShows(from: Endpoint.popular, params: nil, successHandler: {[unowned self] (response) in
            self.popularShows = response.results
            group.leave()
            }, errorHandler: {[unowned self] (error) in
                group.leave()
                print("\(error.localizedDescription)")
        })
        
        group.enter()
        showService.fetchShows(from: Endpoint.topRated, params: nil, successHandler: {[unowned self] (response) in
            self.topRatedShows = response.results
            group.leave()
            }, errorHandler: {[unowned self] (error) in
                group.leave()
                print("\(error.localizedDescription)")
        })
        
        group.notify(queue: .main) {
            self.configureDataSource()
        }
    }
    
    func configureCollectionView() {
        let collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: generateLayout())
        view.addSubview(collectionView)
        collectionView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        collectionView.backgroundColor = .systemBackground
        collectionView.showsVerticalScrollIndicator = false
        collectionView.delegate = self
        collectionView.register(MainItemCell.self, forCellWithReuseIdentifier: MainItemCell.reuseIdentifer)
        collectionView.register(HeaderView.self, forSupplementaryViewOfKind: MainViewController.sectionHeaderElementKind, withReuseIdentifier: HeaderView.reuseIdentifier)
        collectionView.register(FeaturedMovieItemCell.self, forCellWithReuseIdentifier: FeaturedMovieItemCell.reuseIdentifer)
        collectionView.register(PopularShowItemCell.self, forCellWithReuseIdentifier: PopularShowItemCell.reuseIdentifer)
        collectionView.register(TopRatedShowItemCell.self, forCellWithReuseIdentifier: TopRatedShowItemCell.reuseIdentifer)
        mainCollectionView = collectionView
    }
    
    func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource
        <Section, ShowItem>(collectionView: mainCollectionView) {
            (collectionView: UICollectionView, indexPath: IndexPath, albumItem: ShowItem) -> UICollectionViewCell? in
            
            let sectionType = Section.allCases[indexPath.section]
            switch sectionType {
                case .featuredMovies:
                    guard let cell = collectionView.dequeueReusableCell(
                        withReuseIdentifier: FeaturedMovieItemCell.reuseIdentifer,
                        for: indexPath) as? FeaturedMovieItemCell
                        else { fatalError("Could not create new cell") }
                    cell.featuredPhotoView.kf.setImage(with: albumItem.backdropURL)
                    cell.title = albumItem.name
                    cell.genre = albumItem.name
                    return cell
                case .popularShows:
                    guard let cell = collectionView.dequeueReusableCell(
                        withReuseIdentifier: PopularShowItemCell.reuseIdentifer,
                        for: indexPath) as? PopularShowItemCell
                        else { fatalError("Could not create new cell") }
                    cell.featuredPhotoView.kf.setImage(with: albumItem.posterURL)
                    return cell
                case .topRatedShows:
                    guard let cell = collectionView.dequeueReusableCell(
                        withReuseIdentifier: TopRatedShowItemCell.reuseIdentifer,
                        for: indexPath) as? TopRatedShowItemCell
                        else { fatalError("Could not create new cell") }
                    cell.featuredPhotoView.kf.setImage(with: albumItem.posterURL)
                    return cell
            }
        }
        
        dataSource.supplementaryViewProvider = { (
            collectionView: UICollectionView,
            kind: String,
            indexPath: IndexPath) -> UICollectionReusableView? in
            
            guard let supplementaryView = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: HeaderView.reuseIdentifier,
                for: indexPath) as? HeaderView else { fatalError("Cannot create header view") }
            
            supplementaryView.sectionLabel.text = Section.allCases[indexPath.section].rawValue
            supplementaryView.delegate = self
            supplementaryView.viewAllButton.tag = indexPath.section
            return supplementaryView
        }

        let snapshot = snapshotForCurrentState()
        dataSource.apply(snapshot, animatingDifferences: false)
    }

    func generateLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { (sectionIndex: Int,
        layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
        let isWideView = layoutEnvironment.container.effectiveContentSize.width > 500
        let sectionLayoutKind = Section.allCases[sectionIndex]
            switch (sectionLayoutKind) {
                case .featuredMovies: return self.generateFeaturedMoviesLayout(isWide: isWideView)
                case .popularShows: return self.generatePopularShowsLayout(isWide: isWideView)
            case .topRatedShows: return self.generateTopRatedShowsLayout(isWide: isWideView)
            }
        }
        return layout
    }

    fileprivate func generateFeaturedMoviesLayout(isWide: Bool) -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalWidth(2/3))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        // Show one item plus peek on narrow screens,
        // two items plus peek on wider screens
        let groupFractionalWidth = isWide ? 0.475 : 0.95
        let groupFractionalHeight: Float = isWide ? 1/3 : 2/3
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(CGFloat(groupFractionalWidth)),
            heightDimension: .fractionalWidth(CGFloat(groupFractionalHeight)))
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: groupSize,
            subitem: item,
            count: 1)
        group.contentInsets = NSDirectionalEdgeInsets(
            top: 0,
            leading: 10,
            bottom: 0,
            trailing: 10)
        
        let headerSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .estimated(60))
        let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: headerSize,
            elementKind: MainViewController.sectionHeaderElementKind,
            alignment: .top)
        
        let section = NSCollectionLayoutSection(group: group)
        section.boundarySupplementaryItems = [sectionHeader]
        section.orthogonalScrollingBehavior = .groupPaging
        
        return section
    }
    
    func generatePopularShowsLayout(isWide: Bool) -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalWidth(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .absolute(160),
            heightDimension: .absolute(240))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitem: item, count: 1)
        group.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 10)
        
        let headerSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .estimated(44))
        let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: headerSize,
            elementKind: MainViewController.sectionHeaderElementKind,
            alignment: .top)
        
        let section = NSCollectionLayoutSection(group: group)
        section.boundarySupplementaryItems = [sectionHeader]
        section.orthogonalScrollingBehavior = .groupPaging
        
        
        return section
    }
    
    func generateTopRatedShowsLayout(isWide: Bool) -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalWidth(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .absolute(160),
            heightDimension: .absolute(240))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitem: item, count: 1)
        group.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 10, bottom: 20, trailing: 10)
        
        let headerSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .estimated(44))
        let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: headerSize,
            elementKind: MainViewController.sectionHeaderElementKind,
            alignment: .top)
        
        let section = NSCollectionLayoutSection(group: group)
        section.boundarySupplementaryItems = [sectionHeader]
        section.orthogonalScrollingBehavior = .groupPaging
        
        return section
    }

    func snapshotForCurrentState() -> NSDiffableDataSourceSnapshot<Section, ShowItem> {
        var snapshot = NSDiffableDataSourceSnapshot<Section, ShowItem>()
        snapshot.appendSections([Section.featuredMovies])
        snapshot.appendItems(self.featuredShows)
        
        snapshot.appendSections([Section.popularShows])
        snapshot.appendItems(self.popularShows)
        
        snapshot.appendSections([Section.topRatedShows])
        snapshot.appendItems(self.topRatedShows)
        
        return snapshot
    }
    
}

extension MainViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let item = dataSource.itemIdentifier(for: indexPath) else { return }
        let showDetailVC = ShowDetailViewController()
        showDetailVC.item = item
        navigationController?.pushViewController(showDetailVC, animated: true)
    }
}

extension MainViewController: HeaderViewDelegate {
    func pressButton(_ sender: UIButton) {
        if sender.tag == 0 {
            let viewAllVC = ViewAllViewController()
            viewAllVC.navigationItem.title = "Airing Today"
            navigationController?.pushViewController(viewAllVC, animated: true)
        } else {
            let viewAllVC = ViewAllViewController()
            viewAllVC.navigationItem.title = "Popular"
            navigationController?.pushViewController(viewAllVC, animated: true)
        }
    }
}
