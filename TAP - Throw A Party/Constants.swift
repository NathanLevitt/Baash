//
//  Constants.swift
//  TAP - Throw A Party
//
//  Created by Nathan Levitt on 10/17/16.
//  Copyright © 2016 The Bench Company. All rights reserved.
//

import Foundation
import FirebaseDatabase
import FirebaseAuth
import FirebaseStorage

let BASE_URL = "https://tap-throw-a-party-d355e.firebaseio.com/"

var ref: FIRDatabaseReference = FIRDatabase.database().reference()
var userRef: FIRDatabaseReference = ref.child("users")
var usernameToUidRef: FIRDatabaseReference = ref.child("usernameToUid")
var uidToUsernameRef: FIRDatabaseReference = ref.child("uidToUsername")
var partyPostRef: FIRDatabaseReference = ref.child("partyPost")
var geoFireRef: FIRDatabaseReference = ref.child("geoFire")

let storage = FIRStorage.storage()
let storageRef = storage.reference(forURL: "gs://tap-throw-a-party-d355e.appspot.com/")
let partyImagesRef = storageRef.child("partyImages")
let profileImagesRef = storageRef.child("profileImages")

var user = FIRAuth.auth()?.currentUser
var userID = user?.uid
var userEmail = user?.email
var userUsername = ""
