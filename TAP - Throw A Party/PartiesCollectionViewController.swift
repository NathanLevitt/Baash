//
//  PartiesCollectionViewController.swift
//  TAP - Throw A Party
//
//  Created by Nathan Levitt on 9/17/16.
//  Copyright © 2016 The Bench Company. All rights reserved.
//

import UIKit

class PartiesCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    let reuseIdentifier = "PartyCell"
    
    var horizontalBarView: UIView!
    var horizontalBarBackgroundView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        collectionView?.backgroundColor = UIColor(red: 0.91, green: 0.91, blue: 0.91, alpha: 1.00)
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        //collectionView?.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        collectionView?.register(FeedCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        
        //setupHorizontalBar()
        setupCollectionView()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
//        for subview in navigationController!.navigationBar.subviews {
//            if subview.isKind(of: UILabel.self) {
//                let label = subview as! UILabel
//                label.isHidden = false
//                if label.tag == 111 {
//                    label.isHidden = true
//                }
//            }
//        }
        
//        // Set title when view appears
//        let indexPath = collectionView!.indexPathsForVisibleItems
//        //setTitleForIndex(index: indexPath[0].item)
//        
//        // Show horizontal bar
//        for view in self.navigationController!.navigationBar.subviews {
//            if view.isKind(of: UIView.self) {
//                if view.tag == 23 {
//                    view.alpha = 1.0
//                }
//            }
//        }
        
    }
    
    func setupCollectionView() {
        
        if let layout = collectionView?.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .horizontal
            layout.minimumLineSpacing = 0
        }
        
        //collectionView?.contentInset = UIEdgeInsetsMake(0, 0, tabBarController!.tabBar.frame.height, 0)
        
        collectionView?.isPagingEnabled = true
        collectionView?.bounces = false
    
    }

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! FeedCell
        cell.partiesCollectionController = self
        return cell
    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        return CGSize(width: view.frame.width, height: view.frame.height - tabBarController!.tabBar.frame.height)
//    }
    
    override func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let index = targetContentOffset.pointee.x / view.frame.width
        //setTitleForIndex(index: Int(index))
    }
    
//    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        self.horizontalBarView.frame.origin.x = (scrollView.contentOffset.x / 3)
//    }
    
//    func setupHorizontalBar() {
//        horizontalBarBackgroundView = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 5))
//        horizontalBarBackgroundView.backgroundColor = .tap
//        horizontalBarBackgroundView.tag = 22
//        view.addSubview(horizontalBarBackgroundView)
//        
//        horizontalBarView = UIView()
//        horizontalBarView.frame.origin = CGPoint(x: 0, y: 0)
//        horizontalBarView.frame.size.width = self.view.frame.width / 3
//        horizontalBarView.frame.size.height = 5
//        horizontalBarView.backgroundColor = .white
//        horizontalBarView.layer.zPosition = 100
//        horizontalBarView.tag = 23
//        horizontalBarView.translatesAutoresizingMaskIntoConstraints = false
//        //view.addSubview(horizontalBarView)
//    }
    
    func showPartyDetail(forParty party: Party, image: UIImage, index: IndexPath) {
        let pageIndex = collectionView?.indexPathsForVisibleItems[0].item
        
        print("page index: \(pageIndex) and index: \(index)")
        
        let detailController = PartyDetailsViewController()
        detailController.partyImageView.image = image
        detailController.partyAddressLabel.text = party.address
        detailController.navigationPartyTitle.text = party.name
        self.navigationController!.pushViewController(detailController, animated: true)
        //navigationController?.pushViewController(detailController, animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
