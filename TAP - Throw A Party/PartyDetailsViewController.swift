//
//  PartyDetailsViewController.swift
//  TAP - Throw A Party
//
//  Created by Nathan Levitt on 9/21/16.
//  Copyright © 2016 The Bench Company. All rights reserved.
//

import UIKit
import MapKit

class PartyDetailsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, MKMapViewDelegate {

    var tableView: UITableView!
    
    // section 0: party image
    var partyImageCell: UITableViewCell = UITableViewCell()
    var partyImageView: UIImageView = UIImageView()
    
    // section 1: attending label
    var attendingStatusCell: UITableViewCell = UITableViewCell()
    var attendingStatusLabel: UILabel = UILabel()
    
    // section 2: host label
    var partyHostCell: UITableViewCell = UITableViewCell()
    var partyHostLabel: UILabel = UILabel()
    
    // section 3: description
    var partyDescriptionCell: UITableViewCell = UITableViewCell()
    var partyDescriptionLabel: UILabel = UILabel()
    
    // section 4: address
    var partyAddressCell: UITableViewCell = UITableViewCell()
    var partyAddressLabel: UILabel = UILabel()
    
    // section 5: map
    var partyLocationMapCell: UITableViewCell = UITableViewCell()
    var partyLocationMap: MKMapView = MKMapView()
    
    let navigationPartyTitle: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .white
        label.font = UIFont(name: "Verdana-Bold", size: 18)
        label.tag = 111
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        
        self.view.addSubview(tableView)
        
        // Gets rid of the line seperator
        tableView.separatorStyle = .none
        
        // Background color
        tableView.backgroundColor = .white
        
        // Stop scrolling when reached top or bottom
        //tableView.bounces = false
        
    }
    
    override func loadView() {
        super.loadView()
        
        navigationController?.navigationBar.barTintColor = .tap
        
        for subview in navigationController!.navigationBar.subviews {
            if subview.isKind(of: UILabel.self) {
                let label = subview as! UILabel
                label.isHidden = true
                if label.tag == 111 {
                    label.isHidden = false
                }
            }
        }
        
        navigationPartyTitle.frame = navigationController!.navigationBar.bounds
        view.addSubview(navigationPartyTitle)
        
        tableView = UITableView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height - navigationController!.navigationBar.frame.height - UIApplication.shared.statusBarFrame.height), style: .grouped)
        
        tableView.delegate = self
        tableView.dataSource = self
        
        // Party image cell: section 0, row 0
        partyImageCell.backgroundColor = .brown
        partyImageCell.selectionStyle = .none
        partyImageView.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.width * 9 / 16)
        //partyImageView.image = UIImage(named: "party")
        partyImageView.backgroundColor = .pomegranate
        partyImageView.contentMode = .scaleAspectFill
        partyImageView.clipsToBounds = true
        partyImageCell.addSubview(partyImageView)
        
        // Attending status cell: section 1, row 0
        attendingStatusCell.backgroundColor = .white
        attendingStatusCell.selectionStyle = .none
        attendingStatusLabel.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: attendingStatusCell.frame.height)
        attendingStatusLabel.text = "Attending!"
        attendingStatusLabel.textColor = .tap
        attendingStatusLabel.textAlignment = .center
        attendingStatusLabel.backgroundColor = .yellow
        attendingStatusLabel.font = UIFont(name: "Verdana-Bold", size: attendingStatusLabel.frame.height / 2)
        attendingStatusCell.addSubview(attendingStatusLabel)
        print(attendingStatusLabel.frame)
        print(attendingStatusCell.frame)
        
        // Host label cell: section 2, row 0
        partyHostCell.backgroundColor = .white
        partyHostCell.selectionStyle = .none
        partyHostLabel.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: partyHostCell.frame.height)
        partyHostLabel.numberOfLines = 1
        partyHostLabel.textColor = .pomegranate
        partyHostLabel.font = UIFont(name: "Verdana", size: 13)
        partyHostLabel.text = "Nathan Levitt | @nathanlevitt"
        partyHostLabel.textAlignment = .center
        partyHostCell.addSubview(partyHostLabel)
        
        // Description cell: section 3, row 0
        partyDescriptionCell.backgroundColor = .white
        partyDescriptionCell.selectionStyle = .none
        partyDescriptionLabel.numberOfLines = 0
        partyDescriptionLabel.textAlignment = .center
        partyDescriptionLabel.textColor = .tap
        partyDescriptionLabel.text = "This is about to be the best party of the year.. You better all come down and have fun. Girls free and guys $5 before 10pm and $10 after! BYOB"
        partyDescriptionLabel.font = UIFont(name: "Verdana", size: attendingStatusLabel.frame.height / 2)
        partyDescriptionLabel.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: heightForLabel(text: partyDescriptionLabel.text!, font: partyDescriptionLabel.font, width: partyDescriptionCell.contentView.frame.width) + 10)
        partyDescriptionCell.addSubview(partyDescriptionLabel)

        // Address cell: section 4, row 0
        partyAddressCell.backgroundColor = .white
        partyAddressCell.selectionStyle = .none
        partyAddressLabel.numberOfLines = 0
        partyAddressLabel.textAlignment = .center
        partyAddressLabel.textColor = .pomegranate
        partyAddressLabel.font = UIFont(name: "Verdana-Bold", size: 25)
        //partyAddressLabel.text = "23678 Long Valley Road, Hidden Hills CA 91302"
        partyAddressLabel.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: heightForLabel(text: partyAddressLabel.text!, font: partyAddressLabel.font, width: partyAddressCell.contentView.frame.width) + 10)
        partyAddressCell.addSubview(partyAddressLabel)

        // Map cell: section 5, row 0
        partyLocationMapCell.backgroundColor = .white
        partyLocationMapCell.selectionStyle = .none
        partyLocationMap.mapType = .standard
        partyLocationMap.isScrollEnabled = false
        partyLocationMap.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.width * 9 / 16)
        partyLocationMap.delegate = self
        
        // Add address to map
        showAddressOnMap(latitude: 34.159626, longitude: -118.64349500000003)
        
        partyLocationMapCell.addSubview(partyLocationMap)
        
    }
    
    func showAddressOnMap(latitude: CLLocationDegrees, longitude: CLLocationDegrees) {
        let latitudeDelta: CLLocationDegrees = 0.15
        let longitudeDelta: CLLocationDegrees = 0.15
        let span = MKCoordinateSpanMake(latitudeDelta, longitudeDelta)
        let location = CLLocationCoordinate2DMake(latitude, longitude)
        let region = MKCoordinateRegionMake(location, span)
        partyLocationMap.setRegion(region, animated: false)
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = location
        partyLocationMap.addAnnotation(annotation)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return 1
        case 2:
            return 1
        case 3:
            return 1
        case 4:
            return 1
        case 5:
            return 1
        default: fatalError("Unknown Section")
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            return self.partyImageCell
        case 1:
            return self.attendingStatusCell
        case 2:
            return self.partyHostCell
        case 3:
            return self.partyDescriptionCell
        case 4:
            return self.partyAddressCell
        case 5:
            return self.partyLocationMapCell
        default: fatalError("Unknown cell")
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 || indexPath.section == 5 {
            return CGFloat(self.view.frame.width * 9 / 16)
        } else if indexPath.section == 3 {
            return heightForLabel(text: partyDescriptionLabel.text!, font: partyDescriptionLabel.font, width: partyDescriptionCell.contentView.frame.width) + 10
        } else if indexPath.section == 4 {
            return heightForLabel(text: partyAddressLabel.text!, font: partyAddressLabel.font, width: partyAddressCell.contentView.frame.width) + 10
        }
        
        return UITableViewAutomaticDimension
        
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 || section == 1 || section == 5 {
            // TODO: Make the header the date and address
            return CGFloat.leastNormalMagnitude
        } else if section == 2 || section == 3 || section == 4 {
            return 10
        }
        
        return UITableViewAutomaticDimension
    }
    
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        // Set 0 height for all footers
        return CGFloat.leastNormalMagnitude
    }
    
    func dismissPartyDetailsViewController() {
        self.dismiss(animated: true, completion: nil)
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
