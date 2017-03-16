//
//  SearchView.swift
//  MovieSearch
//
//  Created by Christopher Webb-Orenstein on 3/4/17.
//  Copyright © 2017 Christopher Webb-Orenstein. All rights reserved.
//

import UIKit

class SearchView: UIView {
    
    @IBOutlet weak var searchField: SearchField!
    @IBOutlet weak var searchButton: SearchButton! {
        didSet {
            searchButton.roundedButton = true
        }
    }
    
    override func layoutSubviews() {
        searchButton = SearchButton(frame: CGRect.zero)
    }
}
