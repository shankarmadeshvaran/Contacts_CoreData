//
//  ViewController.swift
//  ListContacts
//
//  Created by Shankar on 01/02/20.
//  Copyright © 2020 Shankar. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var tableviewListContact: UITableView!
    var users:[Users] = []
    var filteredUsers:[Users] = []
    var searchController: UISearchController!
    var shouldShowSearchResults = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableviewListContact.register(UINib(nibName: "CellContact", bundle: nil), forCellReuseIdentifier: "CellContactID")
        configureSearchController()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        users = DatabaseController.getAllUsers()
        tableviewListContact.reloadData()
    }
    
    func configureSearchController() {
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search here..."
        searchController.searchBar.delegate = self
        searchController.searchBar.sizeToFit()
        
        // Place the search bar view to the tableview headerview.
        tableviewListContact.tableHeaderView = searchController.searchBar
    }
}

extension ViewController: UISearchResultsUpdating, UISearchBarDelegate {
    func updateSearchResults(for searchController: UISearchController) {
        let searchString = searchController.searchBar.text
        
        filteredUsers = users.filter({ (user) -> Bool in
            let userName: NSString = user.name! as NSString
            
            return (userName.range(of: searchString ?? "", options: NSString.CompareOptions.caseInsensitive).location) != NSNotFound
        })
        // Reload the tableview.
        tableviewListContact.reloadData()
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        shouldShowSearchResults = true
        tableviewListContact.reloadData()
    }
     
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        shouldShowSearchResults = false
        tableviewListContact.reloadData()
    }
}

extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (shouldShowSearchResults) ? filteredUsers.count : users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellContactID", for: indexPath) as! CellContact
        let user = (shouldShowSearchResults) ? filteredUsers[indexPath.row] : users[indexPath.row]
        if let name = user.name {
            cell.labelName.text = name
        }
        if let number = user.number {
            cell.labelPhonenumber.text = "Phone number: " + number
        }
        if let email = user.email {
            cell.labelEmail.text = "Email: " + email
        }
        
        return cell
    }
    
    
}
