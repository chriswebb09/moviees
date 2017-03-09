//
//  SearchView.swift
//  MovieSearch
//
//  Created by Christopher Webb-Orenstein on 3/4/17.
//  Copyright © 2017 Christopher Webb-Orenstein. All rights reserved.
//

import UIKit

struct ViewModel {
    var searchText: String
}

class SearchView: UIView {
    
    var viewModel = ViewModel(searchText: "")
    
    @IBOutlet weak var searchField: SearchField! {
        didSet {
            if let searchText = searchField.text {
                viewModel.searchText = searchText
            }
        }
    }
  
    @IBOutlet weak var searchButton: SearchButton! {
        didSet {
             searchButton.roundedButton = true
        }
    }
    
    override func layoutSubviews() {
        searchButton = SearchButton(frame: CGRect.zero)
    }
}
