//
//  SearchResultTableViewCell.swift
//  ItunesSearch
//
//  Created by Marc Jacques on 11/15/19.
//  Copyright © 2019 Marc Jacques. All rights reserved.
//

import UIKit

class SearchResultTableViewCell: UITableViewCell {
   
    @IBOutlet weak var titleLable: UILabel!
    
    @IBOutlet weak var artistLabel: UILabel!
    
    var searchResult: SearchResult? {
        didSet {
            updateViews()
        }
    }
    
    private func updateViews() {
        guard let searchResult = searchResult else { return }
        titleLable.text = searchResult.title
        artistLabel.text = searchResult.creator
    }

}
