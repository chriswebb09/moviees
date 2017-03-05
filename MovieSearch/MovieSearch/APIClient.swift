////
////  MovieSearch.swift
////  MovieSearch
////
////  Created by Christopher Webb-Orenstein on 3/4/17.
////  Copyright © 2017 Christopher Webb-Orenstein. All rights reserved.
////
//

import UIKit

typealias JSONData = [String : Any]

final class APIClient {
    
    fileprivate var queue = OperationQueue()
    var movies = [Movie]()
    var pageNumber = 1
    let session = URLSession(configuration: URLSessionConfiguration.default)
    
    deinit {
        print("API client deallocated")
    }
    
    fileprivate func getDataFromUrl(url: URL, completion: @escaping (_ data: Data?, _  response: URLResponse?, _ error: Error?) -> Void) {
        let urlRequest = URLRequest(url:url)
        print(url)
        session.dataTask(with: urlRequest, completionHandler: { data, response, error in
            completion(data, response, error)
        }).resume()
    }
}


