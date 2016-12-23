//
//  SearchViewController.swift
//  TAP - Throw A Party
//
//  Created by Nathan Levitt on 9/18/16.
//  Copyright © 2016 The Bench Company. All rights reserved.
//

import UIKit
import FirebaseDatabase

class SearchViewController: UITableViewController, UISearchResultsUpdating {

    let searchController = UISearchController(searchResultsController: nil)
    
    var usernames = [String]()
    var searchResults = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        
        searchController.searchResultsUpdater = self
        searchController.hidesNavigationBarDuringPresentation = true
        searchController.dimsBackgroundDuringPresentation = false
        searchController.searchBar.sizeToFit()
        self.tableView.tableHeaderView = searchController.searchBar
        
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        getUsernames()
                
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
    
    func getUsernames() {
        usernameToUidRef.observeSingleEvent(of: .value, with: { (snapshot) in
            for username in snapshot.children.allObjects as! [FIRDataSnapshot] {
                let name = username.value as! [String: String]
                self.usernames.append(Array(name.keys).first!)
            }
            self.tableView.reloadData()
        })
    }
    
    func filterContent(for searchText: String) {
        searchResults = usernames.filter({ (username: String) -> Bool in
            let match = username.range(of: searchText, options: .caseInsensitive)
            return match != nil
        })
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        if let searchText = searchController.searchBar.text {
            filterContent(for: searchText)
            // Reload tableview data
            tableView.reloadData()
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchController.isActive ? searchResults.count : usernames.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let username = searchController.isActive ? searchResults[indexPath.row] : usernames[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = username
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        let profileViewController = SelectedUsersProfileViewController()
        
        if let username = cell?.textLabel?.text {
            print(username)
            profileViewController.getUsersData(with: username)
        }
        
        self.navigationController?.pushViewController(profileViewController, animated: true)
    }

}
