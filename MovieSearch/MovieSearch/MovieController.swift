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
    
    var dataSourceForSearchResults: [Movie]? {
        didSet {
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
    var moviees: Results<Movie>!
    let searchController = UISearchController(searchResultsController: nil)
    let layout = UICollectionViewFlowLayout()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    func setupUI() {
        if let collectView = collectionView {
            collectView.collectionViewLayout = layout
            datasource.layoutCells(layout: layout)
        }
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
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! MovieCell
        cell.posterView.image == nil ? cell.activityIndicator.startAnimating() : cell.activityIndicator.stopAnimating()
        searchBarActive == false ? datasource.setupCell(indexPath: indexPath, cell: cell, controller: self) : datasource.setupFilteredCell(indexPath: indexPath, cell: cell, controller: self)
        cell.posterView.loadImageUsingCacheWithUrlString(datasource.movies[indexPath.row].posterImageURL)
        if cell.posterView.image != nil {
            DispatchQueue.main.async {
                cell.activityIndicator.stopAnimating()
            }
        }
        return cell
    }
}


// MARK: UICollectionViewDelegate

extension MovieViewController {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: 100, height: 50)
    }
    
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        if let cell = collectionView.cellForItem(at: indexPath) as? MovieCell {
            cell.isSelected = cell.selectedStyle()
        }
        return true
    }
    
    override func collectionView(_ collectionView: UICollectionView, didUnhighlightItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? MovieCell {
            cell.isSelected = cell.selectedStyle()
        }
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

extension MovieViewController: UISearchControllerDelegate {
    
    func searchBarTextDidBeginEditing(searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(true, animated: true)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBarActive = true
        if let barText = searchBar.text {
            if !barText.isEmpty {
                DispatchQueue.main.async {
                    self.filterContentForSearchText(searchText: barText)
                }
            }
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchBarActive = true
        
        if let barText = searchBar.text {
            navigationController?.navigationBar.topItem?.title = "Filtered: \(barText)"
            if !barText.isEmpty {
                DispatchQueue.main.async {
                    self.filterContentForSearchText(searchText: barText)
                }
            }
        }
    }
    
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        searchBarActive = SearchData().cancelSearching(searchBar, searchBarActive: searchBarActive)
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
            if let movies = self?.datasource.movies {
                self?.dataSourceForSearchResults = Filter.filteredBy(filterFrom: movies, term: searchText)
            }
        }
    }
    
    public func updateSearchResults(for searchController: UISearchController) {
        print("update")
    }
}

extension MovieViewController: UISearchBarDelegate {
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionElementKindSectionHeader:
            let reuseableView = returnHeaderView(indexPath)
            setupResuableView(reuseableView)
            return reuseableView
        default:
            fatalError("Unexpected element kind")
        }
    }
    
    func setupResuableView(_ reuseableView: HeaderReusableView) {
        reuseableView.searchBar = searchController.searchBar
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        definesPresentationContext = true
        reuseableView.searchBar.delegate = self
    }
}


