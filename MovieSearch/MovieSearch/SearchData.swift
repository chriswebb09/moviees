//
//  SearchData.swift
//  MovieSearch
//
//  Created by Christopher Webb-Orenstein on 3/14/17.
//  Copyright © 2017 Christopher Webb-Orenstein. All rights reserved.
//

import UIKit

class SearchData {
    func cancelSearching(_ searchBar: UISearchBar, searchBarActive: Bool) -> Bool {
        searchBar.resignFirstResponder()
        searchBar.text = ""
        return false
    }
}
