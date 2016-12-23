//
//  PartiesMapViewController.swift
//  TAP - Throw A Party
//
//  Created by Nathan Levitt on 9/18/16.
//  Copyright © 2016 The Bench Company. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
import FirebaseDatabase

class PartiesMapViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate, MKMapViewDelegate, CLLocationManagerDelegate {

    var map: MKMapView!
    var collectionView: UICollectionView!
    
    var locationManager = CLLocationManager()
    
    var nearbyParties = [String]()
    var partyLocation = [String: CLLocationCoordinate2D]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .darkGray
        
        navigationController?.navigationBar.backgroundColor = .clear
                
        map = MKMapView(frame: CGRect.zero)
        map.delegate = self
        map.mapType = .satelliteFlyover
        map.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(map)
        
        // Get user's location
        locateUser()
        
        // Add map view constraints
        view.addConstraintWithVisualFormat(format: "H:|[v0]|", views: map)
        view.addConstraintWithVisualFormat(format: "V:|[v0]-\(tabBarController!.tabBar.frame.height)-|", views: map)
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .clear
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(collectionView)
        
        // Add collection view constraints
        view.addConstraintWithVisualFormat(format: "H:|[v0]|", views: collectionView)
        view.addConstraintWithVisualFormat(format: "V:[v0(\(self.view.frame.height * 0.23))]-65-|", views: collectionView)
        
        // Set content inset
        collectionView.contentInset = UIEdgeInsetsMake(0, 10, 0, 10)
        
        collectionView.register(PartyMapCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
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
    
    func locateUser() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
        
        map.showsUserLocation = true
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let userLocation: CLLocation = locations[0] as CLLocation
        
        manager.stopUpdatingLocation()
        
        let coordinates = CLLocationCoordinate2D(latitude: userLocation.coordinate.latitude, longitude: userLocation.coordinate.longitude)
        let span = MKCoordinateSpanMake(0.1, 0.1)
        let region = MKCoordinateRegionMake(coordinates, span)
        
        map.setRegion(region, animated: false)
    }
    
    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        print(mapView.region.center)
        // Get parties based on location
        let location = mapView.region.center
        let mapRect = mapView.visibleMapRect
        let westMapPoint = MKMapPointMake(MKMapRectGetMinX(mapRect), MKMapRectGetMidY(mapRect))
        let eastMapPoint = MKMapPointMake(MKMapRectGetMaxX(mapRect), MKMapRectGetMidY(mapRect))
        let distance = MKMetersBetweenMapPoints(westMapPoint, eastMapPoint)
        print(distance)
        print(location)
        getParties(locationCenter: location, radius: distance / 2)
    }
    
    func getParties(locationCenter: CLLocationCoordinate2D, radius: Double) {
        let geoFire = GeoFire(firebaseRef: geoFireRef)!
        
//        geoFire.setLocation(CLLocation(latitude: 34.159626, longitude: -118.643495), forKey: "party1") { (error) in
//            if (error != nil) {
//                print("An error occured: \(error)")
//            } else {
//                print("Saved location successfully!")
//            }
//        }
//        
//        geoFire.setLocation(CLLocation(latitude: 34.156469, longitude: -118.639812), forKey: "party2") { (error) in
//            if (error != nil) {
//                print("An error occured: \(error)")
//            } else {
//                print("Saved location successfully!")
//            }
//        }
//        
//        geoFire.setLocation(CLLocation(latitude: 34.162470, longitude: -118.634942), forKey: "party3") { (error) in
//            if (error != nil) {
//                print("An error occured: \(error)")
//            } else {
//                print("Saved location successfully!")
//            }
//        }
//        
//        geoFire.setLocation(CLLocation(latitude: 34.162399, longitude: -118.544927), forKey: "party4") { (error) in
//            if (error != nil) {
//                print("An error occured: \(error)")
//            } else {
//                print("Saved location successfully!")
//            }
//        }
        // Clear nearby parites array
        nearbyParties.removeAll()
        map.removeAnnotations(map.annotations)
        
        let center = CLLocation(latitude: 34.159416, longitude: -118.639770)
        // Query locations at [34.159416, -118.639770] with a radius of 1600 meters
        //let circleQuery = geoFire.query(at: center, withRadius: 1.6)
        
        let span = MKCoordinateSpanMake(0.1, 0.1)
        let region = MKCoordinateRegionMake(center.coordinate, span)
        let regionQuery = geoFire.query(with: region)
        
        regionQuery?.observe(.keyEntered, with: { (key, location) in
            print("Key: '\(key!)' entered the search area and is at location '\(location!)'")
            self.nearbyParties.append(key!)
            self.partyLocation["\(key!)"] = location!.coordinate
            
            let annotation = MKPointAnnotation()
            annotation.coordinate = location!.coordinate
            
            annotation.title = "\(key!)"
            
            self.map.addAnnotation(annotation)
        })
        
        regionQuery?.observeReady({ 
            print(self.nearbyParties)
            print(self.partyLocation)
            self.collectionView.reloadData()
            regionQuery?.removeAllObservers()
        })
        
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return nearbyParties.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! PartyMapCollectionViewCell
        
        cell.partyNameLabel.text = "\(nearbyParties[indexPath.row])"
        
        // Add shadow
        cell.layer.shadowColor = UIColor.black.cgColor
        cell.layer.shadowOffset = CGSize(width: -1.0, height: 0)
        cell.layer.shadowRadius = 1.0
        cell.layer.shadowOpacity = 0.7
        cell.layer.masksToBounds = false
        cell.layer.shadowPath = UIBezierPath(rect: cell.bounds).cgPath
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let key = nearbyParties[indexPath.row]
        if let location = partyLocation[key] {
            let span = MKCoordinateSpanMake(0.01, 0.01)
            let region = MKCoordinateRegionMake(location, span)
            map.setRegion(region, animated: true)
        }
    }

    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.frame.width * 9 / 12 / 2, height: collectionView.frame.height)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
