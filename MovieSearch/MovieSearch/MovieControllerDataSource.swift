//
//  MovieControllerDataSource.swift
//  MovieSearch
//
//  Created by Christopher Webb-Orenstein on 3/4/17.
//  Copyright © 2017 Christopher Webb-Orenstein. All rights reserved.
//

import UIKit

class MovieControllerDataSource {
    
    var count: Int {
        return 10
    }
    
    var numberOfSections: Int {
        return 1
    }
    
    func layoutCells(layout: UICollectionViewFlowLayout) {
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        layout.minimumInteritemSpacing = 5.0
        layout.minimumLineSpacing = 5.0
        layout.itemSize = CGSize(width: (UIScreen.main.bounds.size.width - 40)/3, height: ((UIScreen.main.bounds.size.width - 40)/2.5))
    }
    
    func setMovieResults() -> [String] {
        return ["new result"]
    }
}
