////
////  MovieSearch.swift
////  MovieSearch
////
////  Created by Christopher Webb-Orenstein on 3/4/17.
////  Copyright © 2017 Christopher Webb-Orenstein. All rights reserved.
////
//

import UIKit
import Realm
import RealmSwift

typealias JSONData = [String : Any]

final class APIClient {
    
    fileprivate var queue = OperationQueue()
    var allMovies = [Movie]()
    var pageNumber = 1
    let session = URLSession(configuration: URLSessionConfiguration.default)
    let realm = try! Realm()
    var movies: Results<Movie>!
    
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

extension APIClient {
    
    public func sendAPICall(fromUrlString:String, completion: @escaping ([Movie], Int) -> Void) {
        let url = URL(string: fromUrlString)!
        getDataFromUrl(url: url) { [weak self] data, response, error in
            
            guard let data = data else { return }
            
            do {
                let result = try? JSONSerialization.jsonObject(with: data, options:[]) as! [String:AnyObject]
                let dataResponse = result?["Search"] as AnyObject
                let searchData = dataResponse as! [[String:String]]
                
                searchData.forEach { [weak self] finalData in
                    if finalData["Type"] == "movie" {
                        guard let title = finalData["Title"] else { return }
                        guard let year = finalData["Year"] else { return }
                        guard let imdbID = finalData["imdbID"] else { return }
                        guard let posterURL = finalData["Poster"] else { return }
                        let movie = Movie(title: title,
                                          year: year,
                                          director: "none",
                                          cast: ["NONE"],
                                          genre: ["NONE"],
                                          imdbID: imdbID,
                                          posterURL: posterURL)
                        
                        
                        if let realm = try? Realm() {
                            self?.movies = realm.objects(Movie.self)
                            
                            if !(self?.movies.contains(movie))! {
                                try! realm.write {
                                    realm.add(movie)
                                }
                                self?.allMovies.append(movie)
                            }
                        }
                    }
                }
                if let movie = self?.allMovies {
                    completion(movie, 1)
                }
                
            }
        }
    }
}

