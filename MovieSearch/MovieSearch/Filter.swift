//
//  Filter.swift
//  MovieSearch
//
//  Created by Christopher Webb-Orenstein on 3/7/17.
//  Copyright © 2017 Christopher Webb-Orenstein. All rights reserved.
//

import Foundation

struct Filter {
    static func filteredBy(filterFrom: [Movie], term: String) -> [Movie] {
        let predicate = NSPredicate(format: "SELF BEGINSWITH %@", term)
        let searchDataSource = filterFrom.filter { predicate.evaluate(with: $0.title) }
        let sortedData = searchDataSource.sorted { $0.0.title.localizedCaseInsensitiveCompare($0.1.title) == ComparisonResult.orderedAscending }
        return sortedData
    }
}
