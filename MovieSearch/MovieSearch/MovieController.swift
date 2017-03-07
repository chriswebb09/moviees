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
    
    var dataSourceForSearchResults:[Movie]? {
        didSet {
            dataSourceForSearchResults?.forEach {
                print($0.title)
            }
            DispatchQueue.main.async {
                self.collectionView?.reloadData()
            }
        }
    }
    
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
    
    var searchBarActive: Bool = false
    var dataSource:[Movie]?
    var moviees: Results<Movie>!
    var backgroundQueue = DispatchQueue(label: "com.movies", qos: .background)
    
    let searchController = UISearchController(searchResultsController: nil)
    let layout = UICollectionViewFlowLayout()
    let realm = try! Realm()
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
        if searchBarActive == true {
            if let data = dataSourceForSearchResults {
                return data.count
            }
        }
        return datasource.count
    }
    
    func setupCell(indexPath: IndexPath, cell: MovieCell) {
        if ((movies?.count)! >= indexPath.row) && (indexPath.row > 0) {
            if let movie = movies?[indexPath.row] {
                DispatchQueue.main.async {
                    cell.setupCell(movie: movie)
                }
            }
        }
    }
    
    func setupFilteredCell(indexPath: IndexPath, cell: MovieCell) {
        if (dataSourceForSearchResults?.count)! >= indexPath.row && indexPath.row >= 0 {
            if let movie = dataSourceForSearchResults?[indexPath.row] {
                DispatchQueue.main.async {
                    cell.setupCell(movie: movie)
                }
            }
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! MovieCell
        cell.layoutSubviews()
        cell.image == nil ? cell.activityIndicator.startAnimating() : cell.activityIndicator.stopAnimating()
        searchBarActive == false ? self.setupCell(indexPath: indexPath, cell: cell) : setupFilteredCell(indexPath: indexPath, cell: cell)
        return cell
    }
}

extension MovieViewController {
    
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

extension MovieViewController: UISearchControllerDelegate {
    
    func searchBarTextDidBeginEditing(searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(true, animated: true)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBarActive = true
        if (!(searchBar.text?.isEmpty)!) {
            DispatchQueue.main.async {
                self.filterContentForSearchText(searchText: searchBar.text!)
            }
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchBarActive = true
        if (!searchText.isEmpty) {
            DispatchQueue.main.async {
                self.filterContentForSearchText(searchText: searchText)
            }
        }
    }
    
    func cancelSearching(searchBar: UISearchBar) {
        searchBarActive = false
        searchBar.resignFirstResponder()
        searchBar.text = ""
    }
    
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        cancelSearching(searchBar: searchBar)
        DispatchQueue.main.async {
            self.collectionView?.reloadData()
        }
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        searchBarActive = true
        view.endEditing(true)
    }
    
    func searchBarTextDidEndEditing(searchBar: UISearchBar) {
        searchBarActive = false
        searchBar.setShowsCancelButton(false, animated: false)
    }
}

extension MovieViewController: UISearchResultsUpdating {
    
    func filterContentForSearchText(searchText: String) {
        DispatchQueue.main.async { [weak self] in
            self?.dataSourceForSearchResults = Filter.filteredBy(filterFrom: (self?.datasource.movies)!, term: searchText)
        }
    }
    
    public func updateSearchResults(for searchController: UISearchController) {
        print("update")
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
}

extension MovieViewController: UISearchBarDelegate {
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionElementKindSectionHeader:
            let reusableview = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader,
                                                                               withReuseIdentifier:  "CollectionViewHeader",
                                                                               for: indexPath) as! HeaderReusableView
            reusableview.frame = CGRect(x:0 , y:0, width: self.view.frame.width, height:50)
            reusableview.searchBar = searchController.searchBar
            searchController.searchResultsUpdater = self
            searchController.dimsBackgroundDuringPresentation = false
            definesPresentationContext = true
            reusableview.searchBar.delegate = self
            return reusableview
            
        default:
            fatalError("Unexpected element kind")
        }
    }
}
