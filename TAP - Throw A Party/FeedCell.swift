//
//  FeedCell.swift
//  TAP - Throw A Party
//
//  Created by Nathan Levitt on 9/18/16.
//  Copyright © 2016 The Bench Company. All rights reserved.
//

import UIKit
import FirebaseStorage

class FeedCell: PartiesBaseCell, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    var parties: [Party] = [Party]()
    
    var imageURLs: [URL] = [URL]()
    
    var partiesCollectionController: PartiesCollectionViewController?
    
    let cellId = "partyCellId"
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height), collectionViewLayout: layout)
        let color:UIColor = UIColor(red: 0.91, green: 0.91, blue: 0.91, alpha: 1.00)
        collectionView.backgroundColor = color
        collectionView.dataSource = self
        collectionView.delegate = self
        return collectionView
    }()
    
    override func setupViews() {
        super.setupViews()
        
        addSubview(collectionView)
        
        loadParties()
    
        collectionView.register(PartyCell.self, forCellWithReuseIdentifier: cellId)
        
        // Collection view constraints
        //addConstraintWithVisualFormat(format: "H:|[v0]|", views: collectionView)
        //addConstraintWithVisualFormat(format: "V:|[v0]|", views: collectionView)
    }
    
    func loadParties() {
        partyPostRef.observe(.value, with: { (snapshot) in
            for eachParty in snapshot.value as! [String: Any] {
                let dict: Dictionary<String, Any> = [eachParty.key: eachParty.value]
                let post = Party(partyDictionary: dict)
                print(post)
                self.parties.append(post)
                self.collectionView.reloadData()
            }
        })
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return parties.count 
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! PartyCell
        //cell.backgroundColor = .brown
        let partyPost = parties[indexPath.row]
        cell.partyNameLabel.text = partyPost.name
        let details = "\n\(partyPost.address!)\n\n\(partyPost.time!) \(partyPost.date!)"
        cell.partyDetailTextView.text = details
        if let imageURL = partyPost.image {
            
            print(imageURL)
            
            cell.partyImageView.sd_setImage(with: URL(string: imageURL))
            
//            FIRStorage.storage().reference(forURL: imageURL).downloadURL(completion: { (url, error) in
//                if error != nil {
//                    print(error)
//                } else {
//                    print("{{{{{{{{{{{{{{{{{{{{{{{{{")
//                    print(url!)
//                    cell.partyImageView.sd_setImage(with: url!)
//                    print("}}}}}}}}}}}}}}}}}}}}}}}}}")
//                }
//            })
            
            
//            FIRStorage.storage().reference(forURL: imageURL).data(withMaxSize: INT64_MAX, completion: { (data, error) in
//                if error != nil {
//                    print(error?.localizedDescription)
//                } else {
//                    print(imageURL)
//                    print("------------------------------------")
//                    print(UIImage(data: data!))
//                    
//                    //cell.partyImageView.image = UIImage(data: data!)
//                }
//            })
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = (frame.width - 20) * 9 / 16
        return CGSize(width: frame.width, height: height + 5 + 140)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! PartyCell
        partiesCollectionController!.showPartyDetail(forParty: parties[indexPath.row], image: cell.partyImageView.image!, index: indexPath)
    }
    
}

