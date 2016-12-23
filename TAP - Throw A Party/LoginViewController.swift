//
//  LoginViewController.swift
//  TAP - Throw A Party
//
//  Created by Nathan Levitt on 10/15/16.
//  Copyright © 2016 The Bench Company. All rights reserved.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {

    var viewWidth: CGFloat!
    var viewHeight: CGFloat!
    
    var username: String!
    var password: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        
        viewWidth = self.view.frame.width
        viewHeight = self.view.frame.height
        
        username = ""
        password = ""
        
        logoLabel.frame = self.view.frame
        
        overlayView.mask = logoLabel
        
        self.view.addSubview(logoLabel)
        
        self.view.addConstraintWithVisualFormat(format: "H:|[v0]|", views: logoLabel)
        self.view.addConstraintWithVisualFormat(format: "V:[v0(100)]", views: logoLabel)
        self.view.addConstraint(NSLayoutConstraint(item: logoLabel, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1, constant: 0))
        
        moveLogoAnimation()
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func moveLogoAnimation() {
    
        UIView.animate(withDuration: 1.5, delay: 0.5, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseInOut, animations: { 
            
            self.overlayView.image = UIImage(named: "fire")
            //self.overlayView.contentMode = .right
            
            }) { (completed) in
                print("Moved logo complete.")
                self.setupTextFields()
                self.setupConstraints()
            }
        
    }
    
    func setupTextFields() {
    
        //usernameTextField.frame = CGRect(x: 0, y: 0, width: 100, height: 50)
        self.view.addSubview(usernameTextField)
        
        //passwordTextField.frame = CGRect(x: 0, y: self.view.frame.width, width: 100, height: 50)
        self.view.addSubview(passwordTextField)
    
    }
    
    func setupConstraints() {
        
        view.addSubview(loginButton)
        
        // Horizontal Constraints
        view.addConstraintWithVisualFormat(format: "H:|-25-[v0]-25-|", views: usernameTextField)
        view.addConstraintWithVisualFormat(format: "H:|-25-[v0]-25-|", views: passwordTextField)
        view.addConstraintWithVisualFormat(format: "H:|-50-[v0]-50-|", views: loginButton)
    
        // Vertical Constraints
        view.addConstraintWithVisualFormat(format: "V:|-25-[v0]-10-[v1(50)]-10-[v2(50)]-10-[v3(50)]", views: logoLabel, usernameTextField, passwordTextField, loginButton)
        
        print(logoLabel.constraints.count)
        
        UIView.animate(withDuration: 0) {
            self.logoLabel.textColor = .tap
            self.view.layoutIfNeeded()
        }
        
    }
    
    func signIn() {
        if !usernameTextField.text!.isEmpty || !passwordTextField.text!.isEmpty {
            print("Enter cridentials")
        } else {
            // Sign in user
            username = "nathanlevitt"
            password = "nathan"
            // Get user email
            print(username)
            usernameToUidRef.child(username).observeSingleEvent(of: .value, with: { (snapshot) in
                let usernameDict = snapshot.value as! [String: Any]
                let uid = usernameDict[self.username]
                print("The user's uid is \(uid!)")
                
                // Get user's email from uid
                userRef.child(uid! as! String).observeSingleEvent(of: .value, with: { (snapshot) in
                    let emailDict = snapshot.value as! [String: Any]
                    let email = emailDict["email"]
                    print("The user's email is \(email!)")
                    
                    // Sign in the user
                    FIRAuth.auth()?.signIn(withEmail: email! as! String, password: self.password, completion: { (user, error) in
                        if error != nil {
                            print("Error in signing in user")
                        } else {
                            // Transition to main view controller
                            let partiesViewController = UINavigationController(rootViewController: PartiesTabBarController())
                            partiesViewController.navigationBar.isTranslucent = false
                            partiesViewController.navigationBar.tintColor = .white
                            self.present(partiesViewController, animated: true, completion: { 
                                print("Successfully signed in user: \(self.username!) - \(uid!)")
                                userUsername = self.username
                            })
                        }
                    })
                })
                
            })
        }
    }
    
    let logoLabel: UILabel = {
        let label = UILabel()
        label.text = "TAP"
        label.font = UIFont(name: "Chalkduster", size: 70)
        label.textAlignment = .center
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let overlayView: UIImageView = {
        let imageView = UIImageView()
        //imageView.image = UIImage(named: "fire")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.backgroundColor = .black
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let usernameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Username"
        textField.autocapitalizationType = .none
        textField.autocorrectionType = .no
        textField.returnKeyType = .next
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.backgroundColor = .tap
        return textField
    }()
    
    let passwordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Password"
        textField.isSecureTextEntry = true
        textField.autocapitalizationType = .none
        textField.autocorrectionType = .no
        textField.returnKeyType = .done
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.backgroundColor = .orange
        return textField
    }()
    
    lazy var loginButton: UIButton = {
        let button = UIButton()
        button.setTitle("Sign In", for: .normal)
        button.titleLabel?.font = UIFont(name: "Verdana-Bold", size: 20)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .tap
        button.layer.cornerRadius = 0
        button.addTarget(self, action: #selector(LoginViewController.signIn), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
}







