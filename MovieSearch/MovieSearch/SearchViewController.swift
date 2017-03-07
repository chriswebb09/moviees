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
        if let searchText = searchView.searchField, let searchString = searchText.text {
            let encoded = searchString.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed)
            api.sendAPICall(from: "http://www.omdbapi.com/?s=\(encoded!)&page=1") { movie in
                print("fetching data")
            }
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! MovieViewController
        destinationVC.title = "Search term: \(searchView.searchField.text!)"
        destinationVC.navigationController?.navigationBar.topItem?.title = searchView.searchField.text
        destinationVC.setMovies()
     }
    
}
