//
//  MovieCollectionViewController.swift
//  MovieSearch
//
//  Created by Christopher Webb-Orenstein on 2/28/17.
//  Copyright © 2017 Christopher Webb-Orenstein. All rights reserved.
//

import UIKit

private let reuseIdentifier = "movieCell"

class MovieViewController: UICollectionViewController {
    
    var datasource = MovieControllerDataSource() {
        didSet {
            // Test
        }
    }
    let layout = UICollectionViewFlowLayout()
    
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
        cell.titleLabel.text = "Movie"
        return cell
    }
}

// MARK: UICollectionViewDelegate

extension MovieViewController {
    
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        let cell = collectionView.cellForItem(at: indexPath) as! MovieCell
        cell.isSelected = true
        return true
    }
    
    override func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! MovieCell
        cell.isSelected = false
        cell.selectedStyle()
    }
}
