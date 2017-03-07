//
//  MovieCollectionViewController.swift
//  MovieSearch
//
//  Created by Christopher Webb-Orenstein on 2/28/17.
//  Copyright © 2017 Christopher Webb-Orenstein. All rights reserved.
//

import UIKit
import RealmSwift

private let reuseIdentifier = "movieCell"

class MovieViewController: UICollectionViewController {
    
    let realm = try! Realm()
    let layout = UICollectionViewFlowLayout()
    let datasource = MovieControllerDataSource()
    
    var movies = [Movie]() {
        didSet {
            datasource.movies = movies
            DispatchQueue.main.async {
                self.collectionView?.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        edgesForExtendedLayout = []
        collectionView!.collectionViewLayout = layout
        datasource.layoutCells(layout: layout)
        collectionView!.backgroundColor = .lightGray
    }
}

// MARK: UICollectionViewDataSource

extension MovieViewController {

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return datasource.numberOfSections
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return datasource.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! MovieCell
        cell.titleLabel.text = datasource.movies[indexPath.row].title
        cell.posterView.image = UIImage(data: datasource.movies[indexPath.row].image)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return datasource.sizeForItemAt
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return datasource.edgeInset
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumItemSpacingForSectionAt section: Int) -> CGFloat {
        return datasource.miniumItemSpacing
    }
    
    func setMovies() {
        self.movies.removeAll()
        if let realm = try? Realm() {
            let moviees = realm.objects(Movie.self)
            print(moviees)
            moviees.forEach { movie in
                self.movies.append(movie)
            }
        }
    }
}

// MARK: UICollectionViewDelegate

extension MovieViewController {
    
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        let cell = collectionView.cellForItem(at: indexPath) as! MovieCell
        cell.isSelected = true
        cell.selectedStyle()
        return true
    }
    
    override func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? MovieCell {
            cell.isSelected = false
            cell.selectedStyle()
        }
    }
}
