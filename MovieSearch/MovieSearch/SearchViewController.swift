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
    
    //let realm = try! Realm()
    var api = APIClient()
    var movies: [Movie] = [Movie]()
    var viewModel: SearchViewModel = SearchViewModel(searchText: "", url: URL(string: "noe"))
    var backgroundQueue = DispatchQueue(label: "com.movies", qos: .background)
    
    @IBOutlet var searchView: SearchView!
    
    required init?(coder aDecoder: NSCoder? = nil) {
        if let coder = aDecoder {
            super.init(coder: coder)!
        } else {
            super.init()
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
        if let searchText = searchView.searchField.text {
            viewModel.searchText = searchText
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let searchText = searchView.searchField.text {
            viewModel.searchText = searchText
            
            let destinationVC = segue.destination as! MovieViewController
            destinationVC.navigationController?.navigationBar.topItem?.title = viewModel.searchText
            destinationVC.title = "Search term: \(viewModel.searchText)"
            
            let testMovies = destinationVC.datasource.getAll()
            if let search = viewModel.encodeString(viewModel.searchText) {
                api.sendAPICall(from: search) { movie in
                    destinationVC.movies = movie.0
                    destinationVC.movies?.append(contentsOf: testMovies)
                    DispatchQueue.main.async {
                        destinationVC.collectionView?.reloadData()
                    }
                }
            }
        }
    }
    
}
