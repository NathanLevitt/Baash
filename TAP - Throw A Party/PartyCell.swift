//
//  PartyCell.swift
//  TAP - Throw A Party
//
//  Created by Nathan Levitt on 9/18/16.
//  Copyright © 2016 The Bench Company. All rights reserved.
//

import UIKit

class PartyCell: PartiesBaseCell {

    let partyImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .tap
        imageView.image = UIImage()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let priceLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .pomegranate
        label.text = "Free"
        label.font = UIFont(name: "Verdana-Bold", size: 18)
        label.textColor = UIColor.white
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let partyNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Levitt Cups"
        label.font = UIFont(name: "Verdana-Bold", size: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let partyDetailTextView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.text = "23678 Long Valley Road, Hidden Hills, CA 91302"
        textView.font = UIFont(name: "Verdana", size: 14)
        textView.textContainerInset = UIEdgeInsetsMake(0, -4, 0, 0)
        textView.isEditable = false
        textView.isSelectable = false
        textView.isUserInteractionEnabled = false
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
    let whiteBackgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override func setupViews() {
        
        addSubview(whiteBackgroundView)
        addSubview(partyImageView)
        addSubview(priceLabel)
        addSubview(partyNameLabel)
        addSubview(partyDetailTextView)
        
        addConstraintWithVisualFormat(format: "H:|-10-[v0]-10-|", views: partyImageView)
        
        let priceViewWidth = (self.frame.width - 20) * 0.25
        addConstraintWithVisualFormat(format: "H:|-10-[v0(\(priceViewWidth))]", views: priceLabel)
        
        // Vertical Constraints
        addConstraintWithVisualFormat(format: "V:|-10-[v0][v1(148)]|", views: partyImageView, priceLabel)
        
        // White background view constraints
        addConstraintWithVisualFormat(format: "H:|-10-[v0]-10-|", views: whiteBackgroundView)
        addConstraintWithVisualFormat(format: "V:|-10-[v0]|", views: whiteBackgroundView)
        
        // Top Constraint
        addConstraint(NSLayoutConstraint(item: partyNameLabel, attribute: .top, relatedBy: .equal, toItem: partyImageView, attribute: .bottom, multiplier: 1, constant: 8))
        
        // Left Constraint
        addConstraint(NSLayoutConstraint(item: partyNameLabel, attribute: .left, relatedBy: .equal, toItem: priceLabel, attribute: .right, multiplier: 1, constant: 8))
        
        // Right Constraint
        addConstraint(NSLayoutConstraint(item: partyNameLabel, attribute: .right, relatedBy: .equal, toItem: partyImageView, attribute: .right, multiplier: 1, constant: -8))
        
        // Height Constraint
        addConstraint(NSLayoutConstraint(item: partyNameLabel, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0, constant: 30))
        
        // Top Constraint
        addConstraint(NSLayoutConstraint(item: partyDetailTextView, attribute: .top, relatedBy: .equal, toItem: partyNameLabel, attribute: .bottom, multiplier: 1, constant: 0))
        
        // Left Constraint
        addConstraint(NSLayoutConstraint(item: partyDetailTextView, attribute: .left, relatedBy: .equal, toItem: priceLabel, attribute: .right, multiplier: 1, constant: 8))
        
        // Right Constraint
        addConstraint(NSLayoutConstraint(item: partyDetailTextView, attribute: .right, relatedBy: .equal, toItem: partyImageView, attribute: .right, multiplier: 1, constant: -8))
        
        // Height Constraint
        addConstraint(NSLayoutConstraint(item: partyDetailTextView, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0, constant: 97))
        
    }

}
