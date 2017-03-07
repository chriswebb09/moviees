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
    
    func downloadImage(url: URL, handler: @escaping (UIImage) -> Void) {
        print("Download Started")
        getDataFromUrl(url: url) { data, response, error in
            var op1 = BlockOperation {
                guard let data = data, error == nil else { return }
                OperationQueue.main.addOperation {
                    handler(UIImage(data: data)!)
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
    
    public func sendAPICall(fromUrlString:String, completion: @escaping ([Movie], Int) -> Void) {
        let parse = DataParser()
        let url = URL(string: fromUrlString)!
        getDataFromUrl(url: url) { [weak self] data, response, error in
            guard let data = data else { return }
            do {
                let result = try? JSONSerialization.jsonObject(with: data, options:[]) as! [String:AnyObject]
                let dataResponse = result?["Search"] as AnyObject
                let searchData = dataResponse as! [[String:String]]
                parse.parseData(data: searchData)
                if let movie = self?.allMovies {
                    completion(movie, 1)
                }
                
            }
        }
    }
}

