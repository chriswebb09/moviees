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
    
    var pageNumber = 1
    
    let session = URLSession(configuration: URLSessionConfiguration.ephemeral)
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
    
    func downloadImage(url: URL, handler: @escaping (Data) -> Void) {
        print("Download Started")
        getDataFromUrl(url: url) { data, response, error in
            let op1 = BlockOperation {
                guard let data = data, error == nil else { return }
                OperationQueue.main.addOperation {
                    handler(data)
                }
            }
            op1.completionBlock = { [unowned op1] in
                op1.completionBlock = nil
                print("Op1 finished")
            }
            self.queue.addOperation(op1)
        }
    }
}

extension APIClient {
    
    public func sendAPICall(from searchURL: URL, completion: @escaping ([Movie], Int) -> Void) {
        let parse = DataParser()
        let url = searchURL
        var allMovies: [Movie]!
        
        guard searchURL.absoluteString.characters.count > 34 else {
            if let realm = try? Realm() {
                self.movies = realm.objects(Movie.self)
                allMovies = [Movie]()
                self.movies.forEach { movie in
                    allMovies.append(movie)
                }
                
            }
            completion(allMovies, 1)
            return
        }
        
        getDataFromUrl(url: url) { data, response, error in
            guard let data = data else { return }
            do {
                let result = try? JSONSerialization.jsonObject(with: data, options:[]) as! [String: AnyObject]
                
                if let responseString = result?["Response"] as? String {
                    if responseString == "False" {
                        return
                    }
                }
                
                let dataResponse = result?["Search"] as AnyObject
                
                let searchData = dataResponse as! [[String : String]]
                allMovies = parse.parseData(data: searchData)
                
                allMovies.forEach { movie in
                    self.downloadImage(url: URL(string: movie.posterImageURL)!) { data in
                        DispatchQueue.main.async {
                            movie.image = data
                            if let realm = try? Realm() {
                                self.movies = realm.objects(Movie.self)
                                if !(self.movies.contains(movie)) {
                                    try! realm.write {
                                        realm.add(movie, update: true)
                                        realm.refresh()
                                    }
                                    allMovies.append(movie)
                                }
                            }
                        }
                    }
                    completion(allMovies, 1)
                }
            } 
        }
    }
}
