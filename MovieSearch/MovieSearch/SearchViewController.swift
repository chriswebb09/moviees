//
//  SearchViewController.swift
//  MovieSearch
//
//  Created by Christopher Webb-Orenstein on 3/4/17.
//  Copyright © 2017 Christopher Webb-Orenstein. All rights reserved.
//

import UIKit
import RealmSwift

class SearchViewController: UIViewController {
    
    let realm = try! Realm()
    var api = APIClient()
    var movies: [Movie] = [Movie]()
    var backgroundQueue = DispatchQueue(label: "com.movies", qos: .background)
    
    @IBOutlet var searchView: SearchView! {
        didSet {
            print("search view set")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view = searchView
        view.layoutSubviews()
    }
}

// MARK: - Navigation

extension SearchViewController {
    
    @IBAction func search(_ sender: Any) {

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! MovieViewController
        destinationVC.title = "Search term: \(searchView.searchField.text!)"
        destinationVC.navigationController?.navigationBar.topItem?.title = searchView.searchField.text
        if let searchText = searchView.searchField, let searchString = searchText.text {
            let encoded = searchString.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed)
            if let encodedString = encoded {
                let testMovies = destinationVC.datasource.getAll()
                api.sendAPICall(from: "http://www.omdbapi.com/?s=\(encodedString)&page=1") { movie in
                    destinationVC.movies = movie.0
                    destinationVC.movies?.append(contentsOf: testMovies)
                    DispatchQueue.main.async {
                        destinationVC.collectionView?.reloadData()
                    }
                    print("fetching data")
                }
            }
        }
     }
}
