//
//  PartiesTabBarController.swift
//  TAP - Throw A Party
//
//  Created by Nathan Levitt on 9/17/16.
//  Copyright © 2016 The Bench Company. All rights reserved.
//

import UIKit

class PartiesTabBarController: UITabBarController, UITabBarControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        delegate = self
    
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tabBar.barTintColor = .white
        tabBar.tintColor = .pomegranate
        
        let layout = UICollectionViewFlowLayout()
        
        let item1 = PartiesCollectionViewController(collectionViewLayout: layout)
        item1.title = "Parties"
        let icon1 = UITabBarItem(title: nil, image: UIImage(named: "fire"), selectedImage: nil)
        icon1.imageInsets = UIEdgeInsetsMake(6,0,-6,0)
        item1.tabBarItem = icon1
        
        let item2 = SearchViewController()
        item2.title = "Search"
        let icon2 = UITabBarItem(title: nil, image: UIImage(named: "search"), selectedImage: nil)
        icon2.imageInsets = UIEdgeInsetsMake(6,0,-6,0)
        item2.tabBarItem = icon2
        
        let item3 = ThrowAPartyViewController()
        item3.title = "TAP"
        let icon3 = UITabBarItem(title: " ", image: nil, selectedImage: nil)
        icon3.tag = 3
        icon3.imageInsets = UIEdgeInsetsMake(6,0,-6,0)
        item3.tabBarItem = icon3
        
        let item4 = PartiesMapViewController()
        item4.title = "Map"
        let icon4 = UITabBarItem(title: nil, image: UIImage(named: "map"), selectedImage: nil)
        icon4.imageInsets = UIEdgeInsetsMake(6,0,-6,0)
        item4.tabBarItem = icon4
        
        let item5 = UserProfileViewController()
        item5.title = "Profile"
        let icon5 = UITabBarItem(title: nil, image: UIImage(named: "profile"), selectedImage: nil)
        icon5.imageInsets = UIEdgeInsetsMake(6,0,-6,0)
        item5.tabBarItem = icon5
        
        let controllers = [item1, item2, item3, item4, item5] // array of root view controllers displayed by the tab bar interface
        self.viewControllers = controllers
        
        
        
        setupNavigationBarTitle()
        setupTAPButton()

    }
    
    let navigationTitleLabelLeft: UILabel = {
        let label = UILabel()
        label.text = "Plans"
        label.font = UIFont(name: "Verdana-Bold", size: 18)
        label.textColor = .white
        label.backgroundColor = .tap
        label.textAlignment = .center
        return label
    }()
    
    let navigationTitleLabelMiddle: UILabel = {
        let label = UILabel()
        label.text = "Hot List"
        label.font = UIFont(name: "Verdana-Bold", size: 18)
        label.textColor = .white
        label.backgroundColor = .tap
        label.textAlignment = .center
        return label
    }()

    let navigationTitleLabelRight: UILabel = {
        let label = UILabel()
        label.text = "My TAPs"
        label.font = UIFont(name: "Verdana-Bold", size: 18)
        label.textColor = .white
        label.backgroundColor = .tap
        label.textAlignment = .center
        return label
    }()

    
    let TAPButton: UIButton = {
        let button = UIButton()
        button.setTitle("TAP", for: .normal)
        button.titleLabel?.font = UIFont(name: "Verdana-Bold", size: UIScreen.main.bounds.width / 15)
        button.setTitleColor(.tap, for: .normal)
        return button
    }()
    
    
    func setupNavigationBarTitle() {
    
        navigationTitleLabelLeft.frame = CGRect(x: 0, y: 0, width: self.view.frame.width / 3, height: navigationController!.navigationBar.frame.height)
        navigationController?.navigationBar.addSubview(navigationTitleLabelLeft)
        
        navigationTitleLabelMiddle.frame = CGRect(x: self.view.frame.width / 3, y: 0, width: self.view.frame.width / 3, height: navigationController!.navigationBar.frame.height)
        navigationController?.navigationBar.addSubview(navigationTitleLabelMiddle)
        
        navigationTitleLabelRight.frame = CGRect(x: self.view.frame.width / 3 * 2, y: 0, width: self.view.frame.width / 3, height: navigationController!.navigationBar.frame.height)
        navigationController?.navigationBar.addSubview(navigationTitleLabelRight)
        
    }
    
    func setupTAPButton() {
        
        TAPButton.frame = CGRect(x: (self.view.frame.width / 2) - (self.tabBar.frame.width / 10), y: self.view.frame.height - self.tabBar.frame.height, width: self.tabBar.frame.width / 5, height: self.tabBar.frame.height)
        TAPButton.addTarget(self, action: #selector(PartiesTabBarController.TAPButtonPressed), for: .touchUpInside)
        self.view.addSubview(TAPButton)
        
        self.view.layoutIfNeeded()
        
    }
    
    func TAPButtonPressed() {
        print("tapped")
        let TAPViewController: ThrowAPartyViewController = ThrowAPartyViewController()
        let navController = UINavigationController(rootViewController: TAPViewController)
        self.present(navController, animated: true, completion: nil)
    }
    
    func changeNavigationBarTitle(title: String) {
        navigationTitleLabelMiddle.text = title
    }
    
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        print("should select viewController: \(viewController.title!) ?")
        
        navigationTitleLabelLeft.text = ""
        navigationTitleLabelRight.text = ""
        
        switch viewController.title! {
        case "Parties":
            changeNavigationBarTitle(title: "Hot List")
            navigationTitleLabelLeft.text = "Plans"
            navigationTitleLabelRight.text = "My TAPs"
        case "Search":
            changeNavigationBarTitle(title: "search")
        case "Map":
            changeNavigationBarTitle(title: "map")
        case "Profile":
            changeNavigationBarTitle(title: "profile")
        default:
            changeNavigationBarTitle(title: "tap")
        }
        return true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
