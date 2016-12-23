//
//  UserProfileViewController.swift
//  TAP - Throw A Party
//
//  Created by Nathan Levitt on 9/18/16.
//  Copyright © 2016 The Bench Company. All rights reserved.
//

import UIKit

class UserProfileViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        
        // Make profile image a circle
        profileImageView.layer.cornerRadius = self.view.frame.width * 0.25
    
        getUsersData()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        // Hide horizontal bar
        for view in self.navigationController!.navigationBar.subviews {
            if view.isKind(of: UIView.self) {
                if view.tag == 23 {
                    view.alpha = 0
                }
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Get user's data
    func getUsersData() {
        userRef.child(userID!).observe(.value, with: { (snapshot) in
            let userDict = snapshot.value as! [String: Any]
            
            print(userDict)
            
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.lineSpacing = 4
            paragraphStyle.alignment = .center
            
            if let name = userDict["name"] {
                print(name)
                // Name and username label text
                let attributedText = NSMutableAttributedString(string: "\(name as! String)", attributes: [NSFontAttributeName: UIFont.boldSystemFont(ofSize: 20)])
                
                attributedText.append(NSAttributedString(string: "\n@\(userUsername)", attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 17), NSForegroundColorAttributeName: UIColor.tap]))
                
                attributedText.addAttribute(NSParagraphStyleAttributeName, value: paragraphStyle, range: NSMakeRange(0, attributedText.string.characters.count))
                self.nameAndUsernameLabel.attributedText = attributedText
            } else {
                // Name and username label text
                let attributedText = NSMutableAttributedString(string: "\(userUsername)", attributes: [NSFontAttributeName: UIFont.boldSystemFont(ofSize: 20)])
                
                attributedText.append(NSAttributedString(string: "\n@\(userUsername)", attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 17), NSForegroundColorAttributeName: UIColor.tap]))
                
                attributedText.addAttribute(NSParagraphStyleAttributeName, value: paragraphStyle, range: NSMakeRange(0, attributedText.string.characters.count))
                self.nameAndUsernameLabel.attributedText = attributedText
            }
            
            // Bio text
            if let bioText = userDict["bio"] {
                print(bioText)
                self.bioTextView.text = bioText as! String
            } else {
                 self.bioTextView.text = "Yo what up!!! My name is Jagger and I am a badass.. Where all the T.A.P's tonight?? HMU with that addy fooooool    Yo what up!!! My name is Jagger and I am a badass.. Where all the T.A.P's tonight?? HMU with that addy fooooool"
            }
           
        })
    }
    
    let profileImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "fireImage"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    let nameAndUsernameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    let bioTextView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.isScrollEnabled = false
        textView.text = ""
        textView.font = UIFont.systemFont(ofSize: 14)
        textView.textAlignment = .center
        textView.backgroundColor = .clear
        textView.isEditable = false
        textView.isSelectable = false
        return textView
    }()
    
    let settingsButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "settingsIcon"), for: .normal)
        return button
    }()
    
    let tapScoreLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        
        let attributedText = NSMutableAttributedString(string: "T.A.P Score", attributes: [NSFontAttributeName: UIFont.boldSystemFont(ofSize: 25), NSForegroundColorAttributeName: UIColor.tap])
        
        attributedText.append(NSAttributedString(string: "\n122", attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 20), NSForegroundColorAttributeName: UIColor.tap]))
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 10
        paragraphStyle.alignment = .center
        
        attributedText.addAttribute(NSParagraphStyleAttributeName, value: paragraphStyle, range: NSMakeRange(0, attributedText.string.characters.count))
        label.attributedText = attributedText
        
        // TO-DO: delete this line and rearange label
        label.text = ""
        
        return label
    }()
    
    let bioHoldingView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.clear
        view.alpha = 0.75
        return view
    }()
    
    let shadowView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.white
        view.layer.masksToBounds = false
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 1
        view.layer.shadowOffset = CGSize(width: 0, height: 0)
        view.layer.shadowRadius = 0
        return view
    }()
    
    let editProfileButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .pomegranate
        button.setTitle("Edit", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont(name: "Verdana-Bold", size: 18)
        button.layer.shadowOffset = CGSize(width: 0, height: 2)
        button.layer.shadowOpacity = 0.5
        button.layer.shadowRadius = 5
        button.layer.masksToBounds = false
        button.showsTouchWhenHighlighted = true
        return button
    }()
    
    func settingButtonTapped() {
        print("tapped")
//        let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "editProfileViewController")
//        self.present(viewController, animated: true, completion: nil)
        
    }
    
    func setupViews() {
        self.view.backgroundColor = UIColor.white
        
        editProfileButton.addTarget(self, action: #selector(UserProfileViewController.settingButtonTapped), for: .touchUpInside)
        
        // Add items to view
        self.view.addSubview(profileImageView)
        self.view.addSubview(nameAndUsernameLabel)
        self.view.addSubview(bioHoldingView)
        self.bioHoldingView.addSubview(bioTextView)
        //self.view.addSubview(bioTextView)
        self.view.addSubview(settingsButton)
        self.view.addSubview(tapScoreLabel)
        self.view.addSubview(shadowView)
        self.view.addSubview(editProfileButton)
        
        // Profile image view constraints
        let imageViewBoundary = self.view.frame.width * 0.25
        view.addConstraintWithVisualFormat(format: "H:|-(\(imageViewBoundary))-[v0]-(\(imageViewBoundary))-|", views: profileImageView)
        view.addConstraintWithVisualFormat(format: "V:|-20-[v0(\(imageViewBoundary * 2))]", views: profileImageView)
        
        // Name and username label constraints
        let namesLabelLeadingConstraint = NSLayoutConstraint(item: nameAndUsernameLabel, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1, constant: 0)
        let namesLabelTrailingConstraint = NSLayoutConstraint(item: nameAndUsernameLabel, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .trailing, multiplier: 1, constant: 0)
        let namesLabelTopConstraint = NSLayoutConstraint(item: nameAndUsernameLabel, attribute: .top, relatedBy: .equal, toItem: profileImageView, attribute: .bottom, multiplier: 1, constant: 15)
        self.view.addConstraints([namesLabelLeadingConstraint, namesLabelTrailingConstraint, namesLabelTopConstraint])
        
        // Settings button constraints
        let settingsButtonTrailingConstraint = NSLayoutConstraint(item: settingsButton, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .trailing, multiplier: 1, constant: settingsButton.frame.width - 15)
        let settingsButtonTopConstraint = NSLayoutConstraint(item: settingsButton, attribute: .top, relatedBy: .equal, toItem: profileImageView, attribute: .bottom, multiplier: 1, constant: 15)
        self.view.addConstraints([settingsButtonTrailingConstraint, settingsButtonTopConstraint])
        
        settingsButton.addTarget(self, action: #selector(UserProfileViewController.settingButtonTapped), for: .touchUpInside)
        
        // T.A.P score label constraints
        let scoreLeadingConstraints = NSLayoutConstraint(item: tapScoreLabel, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1, constant: 0)
        let scoreTrailingConstraints = NSLayoutConstraint(item: tapScoreLabel, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .trailing, multiplier: 1, constant: 0)
        let scoreBottomConstraints = NSLayoutConstraint(item: tapScoreLabel, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1, constant: -15)
        self.view.addConstraints([scoreLeadingConstraints, scoreTrailingConstraints, scoreBottomConstraints])
        
        // Bio holding view constraints
        let bioHoldingViewLeadingConstraint = NSLayoutConstraint(item: bioHoldingView, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1, constant: 0)
        let bioHoldingViewTrailingConstraint = NSLayoutConstraint(item: bioHoldingView, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .trailing, multiplier: 1, constant: 0)
        let bioHoldingViewTopConstraint = NSLayoutConstraint(item: bioHoldingView, attribute: .top, relatedBy: .equal, toItem: nameAndUsernameLabel, attribute: .bottom, multiplier: 1, constant: 0)
        let bioHoldingViewBottomConstraint = NSLayoutConstraint(item: bioHoldingView, attribute: .bottom, relatedBy: .equal, toItem: tapScoreLabel, attribute: .top, multiplier: 1, constant: 0)
        self.view.addConstraints([bioHoldingViewLeadingConstraint, bioHoldingViewTrailingConstraint, bioHoldingViewTopConstraint, bioHoldingViewBottomConstraint])
        
        // Bio text constraints
        bioHoldingView.addConstraintWithVisualFormat(format: "H:|-[v0]-|", views: bioTextView)
        bioHoldingView.addConstraintWithVisualFormat(format: "V:|-[v0]", views: bioTextView)
        
        // Shadow view constraints
        let shadowViewLeadingConstraint = NSLayoutConstraint(item: shadowView, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1, constant: 0)
        let shadowViewTrailingConstraint = NSLayoutConstraint(item: shadowView, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .trailing, multiplier: 1, constant: 0)
        let shadowViewTopConstraint = NSLayoutConstraint(item: shadowView, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1, constant: -self.view.frame.height * 0.1)
        let shadowViewHeightConstraint = NSLayoutConstraint(item: shadowView, attribute: .height, relatedBy: .equal, toItem: view, attribute: .height, multiplier: 0.1, constant: 0)
        self.view.addConstraints([shadowViewLeadingConstraint, shadowViewTrailingConstraint, shadowViewTopConstraint, shadowViewHeightConstraint])
        
        // Edit profile button constraints
        self.view.addConstraintWithVisualFormat(format: "H:[v0(75)]-35-|", views: editProfileButton)
        self.view.addConstraintWithVisualFormat(format: "V:[v0(75)]-75-|", views: editProfileButton)
        editProfileButton.layer.cornerRadius = 75 / 2
        
    }


}
