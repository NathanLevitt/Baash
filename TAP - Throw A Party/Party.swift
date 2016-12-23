//
//  Party.swift
//  TAP - Throw A Party
//
//  Created by Nathan Levitt on 10/17/16.
//  Copyright © 2016 The Bench Company. All rights reserved.
//

import UIKit
import FirebaseDatabase

struct Party {
    
    var name: String! = ""
    var address: String! = ""
    var date: String! = ""
    var time: String! = ""
    var addedByUser: String! = ""
    var image: String! = ""
    
    init(partyName: String, partyAddress: String, partyDate: String, partyTime: String, addedByUser: String, partyImageURL: String) {
        name = partyName
        address = partyAddress
        date = partyDate
        time = partyTime
        self.addedByUser = addedByUser
        image = partyImageURL
    }
    
    init(partyDictionary: Dictionary<String, Any>) {
        var values = [[String: Any]]()
        let dataDict = partyDictionary
        for eachValue in dataDict.values {
            print(eachValue as! [String: Any])
            values.append(eachValue as! [String: Any])
        }
        
        for value in values {
            if let partyName = value["name"] as? String {
                name = partyName
            } else {
                name = ""
            }
            
            if let partyAddress = value["address"] as? String {
                address = partyAddress
            } else {
                address = ""
            }
            
            if let partyDate = value["date"] as? String {
                date = partyDate
            } else {
                date = ""
            }
            
            if let partyTime = value["time"] as? String {
                time = partyTime
            } else {
                time = ""
            }
            
            if let addedByUser = value["addedByUser"] as? String {
                self.addedByUser = addedByUser
            } else {
                self.addedByUser = ""
            }
            
            if let image = value["imageURL"] as? String {
                self.image = image
            } else {
                self.image = ""
            }
        }
        
    }
    
    func toAny() -> Any {
        return ["name": name!, "address": address!, "date": date!, "time": time!, "addedByUser": addedByUser!, "imageURL": image!]
    }
    
}










