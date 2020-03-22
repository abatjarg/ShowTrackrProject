//
//  SavedShowsViewController.swift
//  ShowTrackr
//
//  Created by abatjarg on 3/1/20.
//  Copyright © 2020 abatjarg. All rights reserved.
//

import UIKit
import CoreData
import Kingfisher

class SavedShowsViewController: UIViewController {
    
    var endpoint: Endpoint?
    let showService: ShowService = ShowItemStore.shared
    var shows: [NSManagedObject] = []
    
    var savedShowsCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let sscv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        sscv.translatesAutoresizingMaskIntoConstraints = false
        sscv.backgroundColor = .white
        sscv.register(SavedShowsCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        return sscv
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        view.addSubview(savedShowsCollectionView)
        
        navigationItem.title = "Saved shows"
        
        savedShowsCollectionView.delegate = self
        savedShowsCollectionView.dataSource = self
        
        NSLayoutConstraint.activate([
            savedShowsCollectionView.topAnchor.constraint(equalTo: view.topAnchor),
            savedShowsCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            savedShowsCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            savedShowsCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    override func viewDidAppear(_ animated: Bool) {
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Show")

        do {
            shows = try managedContext.fetch(fetchRequest)
            savedShowsCollectionView.reloadData()
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
    }
}

extension SavedShowsViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return shows.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = savedShowsCollectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! SavedShowsCollectionViewCell
        
        print(shows[indexPath.row].value(forKey: "id") as! Int)
        
        showService.fetchShow(id: shows[indexPath.row].value(forKey: "id") as! Int, successHandler: { (response) in
            cell.titleLabel.text = response.name
            cell.featuredPhotoView.kf.setImage(with: response.backdropURL)
        }) { (error) in
            print("\(error)")
        }
        
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.frame.width, height: 280)
    }
    
    
}
