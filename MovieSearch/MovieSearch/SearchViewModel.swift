//
//  SearchViewModel.swift
//  MovieSearch
//
//  Created by Christopher Webb-Orenstein on 3/4/17.
//  Copyright © 2017 Christopher Webb-Orenstein. All rights reserved.
//

import Foundation

struct SearchViewModel {
    var searchText: String
    var url: URL?
    
    mutating func encodeString(_ string: String) -> URL? {
        self.url = URL(string: "http://www.omdbapi.com/?s=\(string.urlEncodedString()!)&page=1")!
        return self.url
    }
    
}
