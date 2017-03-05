//
//  SearchViewController.swift
//  MovieSearch
//
//  Created by Christopher Webb-Orenstein on 3/4/17.
//  Copyright © 2017 Christopher Webb-Orenstein. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {
    
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
        // implement search functionality
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! MovieViewController
        //destinationVC.test = ["New Test", "Testable"]
        destinationVC.title = searchView.searchField.text
        destinationVC.navigationController?.navigationBar.topItem?.title = searchView.searchField.text
    }
}
