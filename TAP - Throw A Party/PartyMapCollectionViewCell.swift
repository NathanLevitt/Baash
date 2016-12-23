//
//  PartyMapCollectionViewCell.swift
//  TAP - Throw A Party
//
//  Created by Nathan Levitt on 9/30/16.
//  Copyright © 2016 The Bench Company. All rights reserved.
//

import UIKit

class PartyMapCollectionViewCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .darkGray
        
        setupViews()
        
    }
    
    let partyImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .tap
        imageView.image = UIImage(named: "party")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let partyNameLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .white
        label.text = "Levitt Cups 2k16"
        label.textColor = .tap
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let partyPriceLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .pomegranate
        label.text = "$10"
        label.textAlignment = .center
        label.textColor = .white
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    func setupViews() {
        
        addSubview(partyImageView)
        addSubview(partyNameLabel)
        addSubview(partyPriceLabel)
        
        addConstraintWithVisualFormat(format: "H:|[v0]|", views: partyImageView)
        addConstraintWithVisualFormat(format: "H:|[v0]|", views: partyNameLabel)
        addConstraintWithVisualFormat(format: "H:|[v0]|", views: partyPriceLabel)
        addConstraintWithVisualFormat(format: "V:|[v0(\(self.contentView.frame.height / 2))][v1(\(self.contentView.frame.height / 4))][v2(\(self.contentView.frame.height / 4))]", views: partyImageView, partyNameLabel, partyPriceLabel)

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
}
