//
//  SearchResultsTableViewController.swift
//  ItunesSearch
//
//  Created by Marc Jacques on 11/15/19.
//  Copyright © 2019 Marc Jacques. All rights reserved.
//

import UIKit

class SearchResultsTableViewController: UITableViewController {
    
    let searchResultsController = SearchResultController()
    var resultType: ResultType!
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.delegate = self

    }
    @IBAction func resultType(_ sender: UISegmentedControl) {
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            resultType = ResultType.apps
        case 1:
            resultType = ResultType.musicTrack
        default:
            resultType = ResultType.movie
        }
    }
    
    // MARK: - Table view data source

    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return searchResultsController.searchResults.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SearchCell", for: indexPath)as? SearchResultTableViewCell else { return UITableViewCell() }

        // Configure the cell...
        let searchResult = searchResultsController.searchResults[indexPath.row]
        cell.searchResult = searchResult
        
        return cell
    }

}

extension SearchResultsTableViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchTerm = searchBar.text else { return }
        
        
        searchResultsController.performSearch(searchTerm: searchTerm, resultType: resultType) { (error) in
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
}
