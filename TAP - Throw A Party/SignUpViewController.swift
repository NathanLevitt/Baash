//
//  SignUpViewController.swift
//  TAP - Throw A Party
//
//  Created by Nathan Levitt on 10/15/16.
//  Copyright © 2016 The Bench Company. All rights reserved.
//

import UIKit
import FirebaseAuth

class SignUpViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = .purple
        
        createUser(email: "cbcohen10@yahoo.com", username: "charliecohen", password: "charlie")

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func createUser(email: String, username: String, password: String) {
        
        FIRAuth.auth()?.createUser(withEmail: email, password: password, completion: { (user, error) in
            if error != nil {
                print("Error in creating a user")
            } else {
                userRef.child(user!.uid).setValue(["username": username, "email": email])
                usernameToUidRef.child(username).setValue(["\(username)": user!.uid])
                uidToUsernameRef.child(user!.uid).setValue(["\(user!.uid)": username])
                
                // Transition to main view controller
                let partiesViewController = UINavigationController(rootViewController: PartiesTabBarController())
                partiesViewController.navigationBar.isTranslucent = false
                partiesViewController.navigationBar.backgroundColor = .white
                partiesViewController.navigationBar.tintColor = .tap
                self.present(partiesViewController, animated: true, completion: { 
                    print("Successfully created user: \(username) - \(user!.uid)")
                    userUsername = username
                })
            }
        })
        
    }

}
