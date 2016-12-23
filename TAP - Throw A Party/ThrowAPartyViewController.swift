//
//  ThrowAPartyViewController.swift
//  TAP - Throw A Party
//
//  Created by Nathan Levitt on 9/18/16.
//  Copyright © 2016 The Bench Company. All rights reserved.
//

import UIKit
import FirebaseStorage
import CoreLocation

class ThrowAPartyViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextViewDelegate {

    var tableView: UITableView!
    var imagePicker = UIImagePickerController()
    
    // section 0
    var partyImageCell: UITableViewCell = UITableViewCell()
    var partyImageView: UIImageView = UIImageView()
    
    
    // section 1
    var partyNameCell: UITableViewCell = UITableViewCell()
    var partyLocationCell: UITableViewCell = UITableViewCell()
    var partyDescriptionCell: UITableViewCell = UITableViewCell()
    
    var partyNameTextField: UITextField = UITextField()
    var partyLocationTextField: UITextField = UITextField()
    var partyDescription: UITextView = UITextView()
    
    // section 2
    var partyDateCell: UITableViewCell = UITableViewCell()
    var partyPriceCell: UITableViewCell = UITableViewCell()
    
    var partyDateLabel: UILabel = UILabel()
    var partyPriceLabel: UILabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .tap
        
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.tintColor = .tap
        
        tableView.keyboardDismissMode = .onDrag
        
        self.view.addSubview(tableView)
    }
    
    override func loadView() {
        super.loadView()
        
        setupNavigationBar()
        
        imagePicker.delegate = self
        
        tableView = UITableView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height - navigationController!.navigationBar.frame.height), style: .grouped)
        
        tableView.showsVerticalScrollIndicator = false
        tableView.showsHorizontalScrollIndicator = false
        
        tableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0)
        
        tableView.delegate = self
        tableView.dataSource = self
        
        // construct party image cell: section 0, row 0
        partyImageCell = UITableViewCell(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: (self.view.frame.width) * 9 / 12))
        partyImageCell.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.5)
        partyImageCell.selectionStyle = .none
        partyImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.width * 9 / 16))
        partyImageView.image = UIImage(named: "party")
        partyImageView.backgroundColor = .darkGray
        partyImageView.contentMode = .scaleAspectFill
        partyImageView.clipsToBounds = true
        partyImageCell.addSubview(partyImageView)
        
        // construct party name cell: section 1, row 0
        partyNameCell.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.5)
        partyNameCell.selectionStyle = .none
        partyNameTextField = UITextField(frame: self.partyNameCell.contentView.bounds)
        partyNameTextField.placeholder = "Party Name"
        partyNameTextField.addPaddingViewLeft()
        partyNameCell.addSubview(partyNameTextField)
        
        // construct party location cell: section 1, row 1
        partyLocationCell.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.5)
        partyLocationCell.selectionStyle = .none
        partyLocationTextField = UITextField(frame: self.partyLocationCell.contentView.bounds)
        partyLocationTextField.placeholder = "Address"
        partyLocationTextField.addPaddingViewLeft()
        partyLocationTextField.textColor = .pomegranate
        partyLocationCell.addSubview(partyLocationTextField)
        
        // construct party description cell: section 1, row 2
        partyDescriptionCell.backgroundColor = UIColor(red: 0, green: 1, blue: 1, alpha: 0.5)
        partyDescriptionCell.selectionStyle = .none
        partyDescription = UITextView(frame: CGRect(x: 10, y: 0, width: self.partyDescriptionCell.contentView.frame.width, height: (self.view.frame.width) * 9 / 32))
        partyDescription.delegate = self
        partyDescription.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.0)
        partyDescription.text = "Description"
        partyDescription.font = partyNameTextField.font
        partyDescriptionCell.addSubview(partyDescription)
        
        // construct party date label cell: section 2, row 0
        partyDateCell.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.5)
        partyDateCell.selectionStyle = .none
        partyDateLabel = UILabel(frame: CGRect(x: 15, y: 0, width: self.partyDateCell.contentView.frame.width - 15, height: self.partyDateCell.contentView.frame.height))
        partyDateLabel.text = "Date"
        partyDateCell.addSubview(partyDateLabel)
        
        // construct party price label cell: seciton 2, row 1
        partyPriceCell.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.5)
        partyPriceCell.selectionStyle = .none
        partyPriceLabel = UILabel(frame: CGRect(x: 15, y: 0, width: self.partyPriceCell.contentView.frame.width - 15, height: self.partyPriceCell.contentView.frame.height))
        partyPriceLabel.text = "Price $"
        partyPriceCell.addSubview(partyPriceLabel)
        
    }
    
    let navigationBarLabel: UILabel = {
        let label = UILabel()
        label.text = "Throw A Party"
        label.font = UIFont(name: "Verdana-Bold", size: 15)
        label.textColor = .darkGray
        label.textAlignment = .center
        return label
    }()
    
    func setupNavigationBar() {
        
        navigationBarLabel.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: navigationController!.navigationBar.frame.height)
        navigationController?.navigationBar.addSubview(navigationBarLabel)
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Close", style: .plain, target: self, action: #selector(ThrowAPartyViewController.dismissTAPViewController))
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Publish", style: .plain, target: self, action: #selector(ThrowAPartyViewController.publishParty))
    
    }
    
    func loadImageTapped() {
        print("image")
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .photoLibrary
        
        present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            partyImageView.image = pickedImage
        }
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func createParty(key: String, addedTimeStamp: Int, partyImageUrl: String) {
        print(userID!)
        
        // Add party to database
        let theparty = Party(partyName: "\(partyNameTextField.text!)", partyAddress: "350 5th Ave, New York, NY 10118", partyDate: "October 31", partyTime: "21:00", addedByUser: userUsername, partyImageURL: partyImageUrl)
        print(theparty.toAny())
        partyPostRef.child("\(key)").setValue(theparty.toAny())
        self.dismissTAPViewController()
        
        // Add location to database
        CLGeocoder().geocodeAddressString(partyLocationTextField.text!) { (placemarks, error) in
            if error != nil {
                print(error?.localizedDescription)
            } else {
                if placemarks!.count > 0 {
                    let placemark = placemarks?[0]
                    let location = placemark?.location
                    let coordinate = location?.coordinate
                    print("lat: \(coordinate!.latitude), long: \(coordinate!.longitude)")
                    // Add location using GeoFire
                    let geoFire = GeoFire(firebaseRef: geoFireRef)
                    geoFire?.setLocation(CLLocation(latitude: coordinate!.latitude, longitude: coordinate!.longitude), forKey: key)
                }
            }
        }
        
    }
    
    func saveImageToFirebaseStorage(key: String, addedTimeStamp: Int) {
        var data = Data()
        data = UIImageJPEGRepresentation(partyImageView.image!, 0.8)!
        // Set upload path
        let filePath = "\("partyImages")/\(key)"
        let metaData = FIRStorageMetadata()
        metaData.contentType = "image/jpg"
        storageRef.child(filePath).put(data, metadata: metaData) { (metaData, error) in
            if error != nil {
                print(error?.localizedDescription)
            } else {
                // Store downloadURL at database
                userRef.child(userID!).child("TAPs").updateChildValues(["\(addedTimeStamp)": key])
                print(metaData?.downloadURL()?.absoluteString)
                
                self.createParty(key: key, addedTimeStamp: addedTimeStamp, partyImageUrl: metaData!.downloadURL()!.absoluteString)
            }
        }
        
    }
    
    func dismissTAPViewController() {
        self.dismiss(animated: true, completion: nil)
        print(randomString(length: 15))
        print(Timestamp)
    }
    
    func publishParty() {
        print("publish party")
        
        let key = randomString(length: 15)
        let timestamp = Int(Timestamp)
        
        saveImageToFirebaseStorage(key: key, addedTimeStamp: timestamp)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return 3
        case 2:
            return 2
        default: fatalError("Unknown number of sections")
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            return self.partyImageCell
        case 1:
            switch indexPath.row {
            case 0:
                return self.partyNameCell
            case 1:
                return self.partyLocationCell
            case 2:
                return self.partyDescriptionCell
            default: fatalError("Unknown cell in section 1")
            }
        case 2:
            switch indexPath.row {
            case 0:
                return self.partyDateCell
            case 1:
                return self.partyPriceCell
            default: fatalError("Unknown cell in section 2")
            }
        default: fatalError("Unknown section")
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            loadImageTapped()
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return ""
        case 1:
            return "Event Information"
        case 2:
            return ""
        default: fatalError("Unknown section")
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 && indexPath.row == 0 {
            let height = (self.view.frame.width) * 9 / 16
            return height
        } else if indexPath.section == 1 && indexPath.row == 2 {
            let height = (self.view.frame.width) * 9 / 32
            return height
        }
        
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return CGFloat.leastNormalMagnitude
        }
        return UITableViewAutomaticDimension
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        tableView.setContentOffset(CGPoint(x: 0, y: textView.center.y + 150), animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}




















