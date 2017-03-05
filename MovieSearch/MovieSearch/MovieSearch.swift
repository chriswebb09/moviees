////
////  MovieSearch.swift
////  MovieSearch
////
////  Created by Christopher Webb-Orenstein on 3/4/17.
////  Copyright © 2017 Christopher Webb-Orenstein. All rights reserved.
////
//
//import UIKit
//typealias JSONData = [String : Any]
//
//final class APIClient {
//    fileprivate let store = DataStore.sharedInstance
//    fileprivate var queue = OperationQueue()
//    static let sharedInstance = APIClient()
//    var movies = [Movie]()
//    var pageNumber = 1
//    let session = URLSession(configuration: URLSessionConfiguration.default)
//    
//    deinit {
//        print("API client deallocated")
//    }
//}
//
//extension APIClient {
//    
//    
//    fileprivate func getDataFromUrl(url: URL, completion: @escaping (_ data: Data?, _  response: URLResponse?, _ error: Error?) -> Void) {
//        let urlRequest = URLRequest(url:url)
//        print(url)
//        session.dataTask(with: urlRequest, completionHandler: { data, response, error in
//            completion(data, response, error)
//        }).resume()
//    }
//    
//    func downloadImage(url: URL, handler: @escaping (UIImage) -> Void) {
//        print("Download Started")
//        getDataFromUrl(url: url) { [unowned self] data, response, error in
//            var op1 = BlockOperation {
//                guard let data = data, error == nil else { return }
//                OperationQueue.main.addOperation {
//                    handler(UIImage(data: data)!)
//                }
//            }
//            op1.completionBlock = { [unowned op1] in
//                op1.completionBlock = nil
//                print("Op1 finished")
//            }
//            self.queue.addOperation(op1)
//        }
//    }
//}
//
//extension APIClient {
//    
//    public func sendAPICall(fromUrlString:String, completion: @escaping ([Movie], Int) -> Void) {
//        let url = URL(string: fromUrlString)!
//        getDataFromUrl(url: url) { [weak self] data, response, error in
//            
//            guard let data = data else { return }
//            do {
//                let result = try? JSONSerialization.jsonObject(with: data, options:[]) as! [String:AnyObject]
//                let dataResponse = result?["Search"] as AnyObject
//                let searchData = dataResponse as! [[String:String]]
//                
//                searchData.forEach { [weak self] finalData in
//                    if finalData["Type"] == "movie" {
//                        guard let title = finalData["Title"] else { return }
//                        guard let year = finalData["Year"] else { return }
//                        guard let imdbID = finalData["imdbID"] else { return }
//                        guard let genre = finalData["Type"] else { return }
//                        guard let posterURL = finalData["Poster"] else { return }
//                        let movie = Movie(title: title,
//                                          year: year,
//                                          director: "None",
//                                          cast: ["NONE"],
//                                          genre: [genre],
//                                          imdbID: imdbID,
//                                          posterURL: posterURL)
//                        self?.movies.append(movie)
//                    }
//                    
//                }
//                let resultsNumber = result?["totalResults"]! as! String
//                if let movie = self?.movies {
//                    completion(movie, Int(resultsNumber)!)
//                }
//                
//            }
//        }
//    }
//}
//
//
//extension APIClient {
//    func getMovieDetails(fromID:String, completion: @escaping (Movie) -> Void) {
//        // "www.omdbapi.com/?i=\(fromID)&plot=short&r=json"
//        /* www.omdbapi.com/?i=tt1403981&plot=short&r=json */
//    }
//}
