//
//  SearchResultController.swift
//  ItunesSearch
//
//  Created by Marc Jacques on 11/15/19.
//  Copyright © 2019 Marc Jacques. All rights reserved.
//

import Foundation

enum HTTPMethod: String {
    case get    =   "GET"
    case post   =   "POST"
    case put    =   "PUT"
    case delete =   "DELETE"
    
    class SearchResultController {
        var seachResults: [SearchResult] = []
        let baseURL = URL(string: "https://itunes.apple.com/search?")!
        
        func performSearch(searchTerm: String, resultType: ResultType, completion: @escaping (Error?) -> Void) {
            var urlComponents = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)
            let searchQueryItem = URLQueryItem(name: "term", value: searchTerm)
            let resultTypeQueryItem = URLQueryItem(name: "entity", value: resultType.rawValue)
            urlComponents?.queryItems! += [searchQueryItem, resultTypeQueryItem]
            
            //url needs to be like this: https://itunes.apple.com/search?term=[searchTerm]
            guard let requestURL = urlComponents?.url else {
                print("requestURL did not work")
                completion(NSError())
                return
            }
            
            var request = URLRequest(url: requestURL)
            request.httpMethod = HTTPMethod.get.rawValue
            
            URLSession.shared.dataTask(with: request) { data, _, error in
                if let error = error {
                    print("Error searching for data: \(error)")
                    completion(error)
                }
                
                guard let data = data else {
                    print("No data returned from data task.")
                    completion(NSError())
                    return
                }
                
                let jsonDecoder = JSONDecoder()
                do {
                    let search = try jsonDecoder.decode(SearchResults.self, from: data)
                    self.seachResults.append(contentsOf: search.results)
                    completion(nil)
                } catch {
                    print("Unable to decode data into object of type [SearchResult]: \(error)")
                    completion(error)
                }
            }.resume()
            
        }
    }
}
