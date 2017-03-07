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
typealias FinishedDownload = () -> ()

class MovieViewController: UICollectionViewController, UISearchBarDelegate, UISearchControllerDelegate, UISearchResultsUpdating {
    
    var dataSource:[Movie]?
    
    let searchController = UISearchController(searchResultsController: nil)
    var dataSourceForSearchResult:[String]?
    var dataSourceForSearchResults:[Movie]?
    let realm = try! Realm()
    var moviees: Results<Movie>!
    
    let layout = UICollectionViewFlowLayout()
    var backgroundQueue = DispatchQueue(label: "com.movies", qos: .background)
    var datasource = MovieControllerDataSource() {
        
        didSet {
            DispatchQueue.main.async {
                self.collectionView?.reloadData()
            }
            
        }
    }
    
    var movies: [Movie]? = [] {
        didSet {
            datasource.movies = movies!
            DispatchQueue.main.async {
                self.collectionView?.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.dataSourceForSearchResult = [String]()
        collectionView?.delegate = self
        collectionView?.dataSource = self
        definesPresentationContext = true
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
        if datasource.count == 0 {
            DispatchQueue.main.async {
                collectionView.reloadData()
            }
        }
        return datasource.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! MovieCell
        
        
        cell.layoutSubviews()
        if cell.image == nil {
            cell.activityIndicator.startAnimating()
        }
        if ((self.movies?.count)! >= indexPath.row) && (indexPath.row > 0) {
            if let movie = self.movies?[indexPath.row] {
                DispatchQueue.main.async {
                    cell.setupCell(movie: movie)
                }
            }
        }
        if cell.image != nil {
            DispatchQueue.main.async {
                cell.activityIndicator.isHidden = true
                cell.activityIndicator.stopAnimating()
            }
        }
        
        
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
    
    
    
}

//MARK: - Search

extension MovieViewController {
    
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.filterContentForSearchText(searchText: searchBar.text!)
        self.collectionView?.reloadData()
        print(searchBar.text)
        if (!(searchBar.text?.isEmpty)!) {
            self.collectionView?.reloadData()
        }
        print(dataSourceForSearchResult)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.filterContentForSearchText(searchText: searchText)
        print(dataSourceForSearchResults)
        self.collectionView?.reloadData()
        if (searchText.isEmpty) {
            self.collectionView?.reloadData()
        }
    }
}


// MARK: UICollectionViewDelegate

extension MovieViewController {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: 100, height: 50)
    }
    
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        if let cell = collectionView.cellForItem(at: indexPath) as? MovieCell {
            cell.isSelected = true
            cell.selectedStyle()
        }
        
        
        return true
    }
    
    override func collectionView(_ collectionView: UICollectionView, didUnhighlightItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? MovieCell {
            cell.isSelected = false
            cell.selectedStyle()
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? MovieCell {
            cell.isSelected = false
            cell.selectedStyle()
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        switch kind {
        case UICollectionElementKindSectionHeader:
            let reusableview = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier:  "CollectionViewHeader", for: indexPath) as! HeaderReusableView
            
            reusableview.frame = CGRect(x:0 , y:0, width:self.view.frame.width, height:50)
            reusableview.searchBar = searchController.searchBar
            searchController.searchResultsUpdater = self
            searchController.dimsBackgroundDuringPresentation = false
            definesPresentationContext = true
            reusableview.searchBar.delegate = self
            return reusableview
            
            
        default:  fatalError("Unexpected element kind")
        }
    }
    
    func filterContentForSearchText(searchText: String) {
        self.dataSourceForSearchResults = self.datasource.movies.filter({ (movie: Movie) -> Bool in
            return movie.title.contains(searchText)
        })
        
    }
    
    public func updateSearchResults(for searchController: UISearchController) {
        print("update")
    }
    
}
