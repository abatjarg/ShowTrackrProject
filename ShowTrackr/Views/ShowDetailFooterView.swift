//
//  ShowDetailFooterView.swift
//  ShowTrackr
//
//  Created by abatjarg on 3/11/20.
//  Copyright © 2020 abatjarg. All rights reserved.
//

import UIKit

class ShowDetailFooterView: UICollectionReusableView {
    
    static let reuseIdentifier = "show-detail-footer-reuse-identifier"
    
    static let labelFont = UIFont.boldSystemFont(ofSize: 12)
    let labelHeight = CGFloat.init(15)
    
    let sectionSeperator: UIView = {
        let seperator = UIView()
        seperator.translatesAutoresizingMaskIntoConstraints = false
        seperator.backgroundColor = UIColor(red:0.88, green:0.88, blue:0.88, alpha:1.0) //UIColor(red:0.94, green:0.94, blue:0.96, alpha:1.0)
        return seperator
    }()
    
    let containerView: UIView = {
        let cv = UIView()
        cv.translatesAutoresizingMaskIntoConstraints = false
        return cv
    }()
    
    let informationLabel: UILabel = {
        let iv = UILabel()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.text = "Information"
        //iv.font = UIFont.preferredFont(forTextStyle: .headline, compatibleWith: nil)
        iv.font = UIFont.boldSystemFont(ofSize: 25)
        return iv
    }()
    
    var creatorLabel: UILabel = {
        let rtl = UILabel()
        rtl.translatesAutoresizingMaskIntoConstraints = false
        rtl.text = "Created By"
        //rtl.font = UIFont.preferredFont(forTextStyle: .subheadline, compatibleWith: nil)
        rtl.font = labelFont
        return rtl
    }()
    
    var creatorValueLabel: UILabel = {
        let rtlv = UILabel()
        rtlv.translatesAutoresizingMaskIntoConstraints = false
        rtlv.text = "Alex Kurtzman"
        //rtlv.font = UIFont.preferredFont(forTextStyle: .footnote, compatibleWith: nil)
        rtlv.font = labelFont
        return rtlv
    }()
    
    var runTimeLabel: UILabel = {
        let rtl = UILabel()
        rtl.translatesAutoresizingMaskIntoConstraints = false
        rtl.text = "Runtime"
        //rtl.font = UIFont.preferredFont(forTextStyle: .subheadline, compatibleWith: nil)
        rtl.font = labelFont
        return rtl
    }()
    
    var runTimeValueLabel: UILabel = {
        let rtlv = UILabel()
        rtlv.translatesAutoresizingMaskIntoConstraints = false
        rtlv.text = "44 min"
        //rtlv.font = UIFont.preferredFont(forTextStyle: .footnote, compatibleWith: nil)
        rtlv.font = labelFont
        return rtlv
    }()
    
    var languageLabel: UILabel = {
        let rtl = UILabel()
        rtl.translatesAutoresizingMaskIntoConstraints = false
        rtl.text = "Original Language"
        //rtl.font = UIFont.preferredFont(forTextStyle: .subheadline, compatibleWith: nil)
        rtl.font = labelFont
        return rtl
    }()
    
    var languageValueLabel: UILabel = {
        let rtlv = UILabel()
        rtlv.translatesAutoresizingMaskIntoConstraints = false
        rtlv.text = "English"
        //rtlv.font = UIFont.preferredFont(forTextStyle: .footnote, compatibleWith: nil)
        rtlv.font = labelFont
        return rtlv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = UIColor(red:0.97, green:0.97, blue:0.98, alpha:1.0)
        
        addSubview(containerView)
        containerView.addSubview(sectionSeperator)
        containerView.addSubview(informationLabel)
        
        containerView.addSubview(creatorLabel)
        containerView.addSubview(creatorValueLabel)
        
        containerView.addSubview(runTimeLabel)
        containerView.addSubview(runTimeValueLabel)
        
        containerView.addSubview(languageLabel)
        containerView.addSubview(languageValueLabel)
        
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: topAnchor),
            containerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            sectionSeperator.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 40),
            sectionSeperator.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            sectionSeperator.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20),
            sectionSeperator.heightAnchor.constraint(equalToConstant: 1.5),
            
            informationLabel.topAnchor.constraint(equalTo: sectionSeperator.topAnchor, constant: 20),
            informationLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            informationLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20),
            informationLabel.heightAnchor.constraint(equalToConstant: 30),
            
            creatorLabel.topAnchor.constraint(equalTo: informationLabel.topAnchor, constant: 40),
            creatorLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            creatorLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20),
            creatorLabel.heightAnchor.constraint(equalToConstant: labelHeight),
            
            creatorValueLabel.topAnchor.constraint(equalTo: creatorLabel.topAnchor, constant: 20),
            creatorValueLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            creatorValueLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20),
            creatorValueLabel.heightAnchor.constraint(equalToConstant: labelHeight),
            
            runTimeLabel.topAnchor.constraint(equalTo: creatorValueLabel.topAnchor, constant: 40),
            runTimeLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            runTimeLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20),
            runTimeLabel.heightAnchor.constraint(equalToConstant: labelHeight),
            
            runTimeValueLabel.topAnchor.constraint(equalTo: runTimeLabel.topAnchor, constant: 20),
            runTimeValueLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            runTimeValueLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20),
            runTimeValueLabel.heightAnchor.constraint(equalToConstant: labelHeight),
            
            languageLabel.topAnchor.constraint(equalTo: runTimeValueLabel.topAnchor, constant: 40),
            languageLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            languageLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20),
            languageLabel.heightAnchor.constraint(equalToConstant: labelHeight),
            
            languageValueLabel.topAnchor.constraint(equalTo: languageLabel.topAnchor, constant: 20),
            languageValueLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            languageValueLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20),
            languageValueLabel.heightAnchor.constraint(equalToConstant: labelHeight),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
