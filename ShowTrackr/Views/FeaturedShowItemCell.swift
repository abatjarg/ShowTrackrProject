//
//  FeaturedMovieItemCell.swift
//  UICollectionViewCompositionalLayoutShowTrackr
//
//  Created by abatjarg on 12/22/19.
//  Copyright © 2019 abatjarg. All rights reserved.
//

import UIKit

class FeaturedMovieItemCell: UICollectionViewCell {
  static let reuseIdentifer = "featured-movie-item-cell-reuse-identifier"
  let titleLabel = UILabel()
  let genreLabel = UILabel()
  let featuredPhotoView = UIImageView()
  let contentContainer = UIView()
    
    var container: UIView = {
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

  var title: String? {
    didSet {
      configure()
    }
  }

  var genre: String? {
    didSet {
      configure()
    }
  }

  var featuredPhotoURL: String? {
    didSet {
      configure()
    }
  }

  override init(frame: CGRect) {
    super.init(frame: frame)
    configure()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

extension FeaturedMovieItemCell {
  func configure() {
    contentContainer.translatesAutoresizingMaskIntoConstraints = false

    contentView.addSubview(container)
    contentView.addSubview(featuredPhotoView)
    contentView.addSubview(contentContainer)

    featuredPhotoView.translatesAutoresizingMaskIntoConstraints = false
//    guard let featuredPhotoURL = self.featuredPhotoURL else { return };
//    let photo = UIImage(named: featuredPhotoURL)
//    featuredPhotoView.image = photo
    featuredPhotoView.layer.cornerRadius = 7
    featuredPhotoView.clipsToBounds = true
    contentContainer.addSubview(featuredPhotoView)

    titleLabel.translatesAutoresizingMaskIntoConstraints = false
    titleLabel.text = title
    titleLabel.font = UIFont.preferredFont(forTextStyle: .headline)
    titleLabel.adjustsFontForContentSizeCategory = true
    contentContainer.addSubview(titleLabel)

    genreLabel.translatesAutoresizingMaskIntoConstraints = false
    genreLabel.text = genre
    genreLabel.font = UIFont.preferredFont(forTextStyle: .subheadline)
    genreLabel.textColor = .lightGray
    genreLabel.adjustsFontForContentSizeCategory = true
    contentContainer.addSubview(genreLabel)

    let spacing = CGFloat(10)
    NSLayoutConstraint.activate([
      contentContainer.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
      contentContainer.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
      contentContainer.topAnchor.constraint(equalTo: contentView.topAnchor),
      contentContainer.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
      
      featuredPhotoView.topAnchor.constraint(equalTo: container.topAnchor),
      featuredPhotoView.leadingAnchor.constraint(equalTo: container.leadingAnchor),
      featuredPhotoView.trailingAnchor.constraint(equalTo: container.trailingAnchor),
      featuredPhotoView.bottomAnchor.constraint(equalTo: container.bottomAnchor),

      container.leadingAnchor.constraint(equalTo: contentContainer.leadingAnchor),
      container.trailingAnchor.constraint(equalTo: contentContainer.trailingAnchor),
      container.topAnchor.constraint(equalTo: contentContainer.topAnchor),
      
      genreLabel.topAnchor.constraint(equalTo: container.bottomAnchor, constant: spacing),
      genreLabel.leadingAnchor.constraint(equalTo: featuredPhotoView.leadingAnchor),
      genreLabel.trailingAnchor.constraint(equalTo: featuredPhotoView.trailingAnchor),

      titleLabel.topAnchor.constraint(equalTo: genreLabel.bottomAnchor),
      titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
      titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
      titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
    ])
  }
}
