//
//  Extensions.swift
//  TAP - Throw A Party
//
//  Created by Nathan Levitt on 9/18/16.
//  Copyright © 2016 The Bench Company. All rights reserved.
//

import UIKit
import FirebaseDatabase

var Timestamp: TimeInterval {
    return NSDate().timeIntervalSince1970 * 1000
}

func heightForLabel(text: String, font: UIFont, width: CGFloat) -> CGFloat {
    let label = UILabel(frame: CGRect(x: 0, y: 0, width: width, height: CGFloat.greatestFiniteMagnitude))
    label.numberOfLines = 0
    label.lineBreakMode = .byWordWrapping
    label.font = font
    label.text = text
    
    label.sizeToFit()
    return label.frame.height
}

func randomString(length: Int) -> String {
    
    let letters : NSString = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
    let len = UInt32(letters.length)
    
    var randomString = ""
    
    for _ in 0 ..< length {
        let rand = arc4random_uniform(len)
        var nextChar = letters.character(at: Int(rand))
        randomString += NSString(characters: &nextChar, length: 1) as String
    }
    
    return randomString
}

extension UIView {

    func addConstraintWithVisualFormat(format: String, views: UIView...) {
        var viewsDictionary = [String: UIView]()
        for(index, view) in views.enumerated() {
            let key = "v\(index)"
            viewsDictionary[key] = view
        }
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: format, options: NSLayoutFormatOptions(), metrics: nil, views: viewsDictionary))
    }
    
}

extension UIImageView {

    func loadImageUsingCache(imageUrl: String) {
    
        let url = URL(string: imageUrl)
        URLSession.shared.dataTask(with: url!) { (data, response, error) in
            if error != nil {
                print(error?.localizedDescription)
                return
            }
            
            DispatchQueue.main.async {
                self.image = UIImage(data: data!)
            }
        }.resume()
    
    }
    
}

extension UITextField {

    func addPaddingViewLeft() {
        let view = UIView()
        view.frame = CGRect(x: 0, y: 0, width: 15, height: self.frame.height)
        self.leftView = view
        self.leftViewMode = .always
    }
    
}

extension UIColor {
    class var tap: UIColor {
        //let color:UIColor = UIColor(red: 1.00, green: 0.32, blue: 0.00, alpha: 1.00)
        let tapcolor:UIColor = UIColor(red: 1.00, green: 0.26, blue: 0.26, alpha: 1.00)
        let color:UIColor = UIColor(red: 0.20, green: 0.20, blue: 0.20, alpha: 1.00)
        return color
    }
    
    class var pomegranate: UIColor {
        return UIColor(red: 192 / 255, green: 57 / 255, blue: 43 / 255, alpha: 1.0)
    }
}
