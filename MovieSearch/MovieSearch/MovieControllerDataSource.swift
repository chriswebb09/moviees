//
//  MovieControllerDataSource.swift
//  MovieSearch
//
//  Created by Christopher Webb-Orenstein on 3/4/17.
//  Copyright © 2017 Christopher Webb-Orenstein. All rights reserved.
//

import UIKit
import Realm
import RealmSwift

class MovieControllerDataSource {
    private let realm = try! Realm()
    
    var movies = [Movie]() 
    
    var count: Int {
        return movies.count
    }
    
    var numberOfSections: Int {
        return 1
    }
    
    var miniumItemSpacing: CGFloat {
        return 20
    }
    
    var sizeForItemAt: CGSize {
        return CGSize(width: UIScreen.main.bounds.height, height: UIScreen.main.bounds.width/3.5)
    }
    
    var edgeInset: UIEdgeInsets {
        return UIEdgeInsets(top:0, left: 0, bottom: 60, right: 0)
    }
    
    func layoutCells(layout: UICollectionViewFlowLayout) {
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        layout.minimumInteritemSpacing = 5.0
        layout.minimumLineSpacing = 5.0
        layout.itemSize = CGSize(width: (UIScreen.main.bounds.size.width - 40)/2, height: ((UIScreen.main.bounds.size.width - 40)/1.8))
    }
    
    func setMovieResults() -> [String] {
        return ["new result"]
    }
    
    
    func getAll() -> [Movie] {
        return realm.objects(Movie.self).map { $0 }
    }
    
}
