//
//  SearchResult.swift
//  ItunesSearch
//
//  Created by Marc Jacques on 11/15/19.
//  Copyright © 2019 Marc Jacques. All rights reserved.
//

import Foundation

struct SearchResult: Codable {
    let title:      String
    let creator:    String
    
    enum CodingKeys: String, CodingKey {
        case title      = "trackName"
        case creator    = "artistName"
    }
}

struct SearchResults: Codable {
    let results: [SearchResult]
}

