//
//  HeaderView.swift
//  ShowTrackr
//
//  Created by abatjarg on 12/17/19.
//  Copyright © 2019 abatjarg. All rights reserved.
//

import UIKit

class HeaderView: UICollectionReusableView {
    
    var delegate: HeaderViewDelegate!
    
    static let reuseIdentifier = "header-reuse-identifier"

    let sectionLabel: UILabel = {
        let sl = UILabel()
        sl.translatesAutoresizingMaskIntoConstraints = false
        sl.adjustsFontForContentSizeCategory = true
        sl.font = UIFont.preferredFont(forTextStyle: .title3)
        return sl
    }()
    
    let viewAllButton: UIButton = {
        let val = UIButton(type: UIButton.ButtonType.roundedRect)
        val.translatesAutoresizingMaskIntoConstraints = false
        val.setTitle("View All", for: .normal)
        val.contentHorizontalAlignment = .trailing
        //val.addTarget(self, action: , for: .touchUpInside)
        return val
    }()
    
    let sectionSeperator: UIView = {
        let seperator = UIView()
        seperator.translatesAutoresizingMaskIntoConstraints = false
        seperator.backgroundColor = UIColor(red:0.94, green:0.94, blue:0.96, alpha:1.0)
        return seperator
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }

    required init?(coder: NSCoder) {
        fatalError()
    }
    
    func setDelegate(delegate: HeaderViewDelegate) {
        self.delegate = delegate
    }
    
    @objc func buttonAction(sender: UIButton!) {
        delegate.pressButton(sender)
    }
}

extension HeaderView {
    func configure() {
        backgroundColor = .systemBackground
        
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.spacing = 0
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false

        stackView.addArrangedSubview(sectionLabel)
        stackView.addArrangedSubview(viewAllButton)
        
        viewAllButton.addTarget(self, action: #selector(self.buttonAction), for: .touchUpInside)
        
        addSubview(sectionSeperator)
        addSubview(stackView)

        NSLayoutConstraint.activate([
            sectionSeperator.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            sectionSeperator.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            sectionSeperator.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            sectionSeperator.heightAnchor.constraint(equalToConstant: 1.5),
            
            stackView.topAnchor.constraint(equalTo: sectionSeperator.bottomAnchor, constant: 10),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20)
        ])
    }
}

public protocol HeaderViewDelegate {
    func pressButton(_ sender: UIButton)
}
