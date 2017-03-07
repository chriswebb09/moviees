//
//  MovieCollectionViewCell.swift
//  MovieSearch
//
//  Created by Christopher Webb-Orenstein on 2/28/17.
//  Copyright © 2017 Christopher Webb-Orenstein. All rights reserved.
//

import UIKit

class MovieCell: UICollectionViewCell {
    
    @IBOutlet weak var posterView: UIImageView! {
        didSet {
            posterView.backgroundColor = .gray
        }
    }
    
    var image: UIImage! {
        willSet {
            print("IMAGE")
        }
    }
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView! {
        didSet {
            self.activityIndicator.hidesWhenStopped = true
            self.activityIndicator.color = .white
        }
    }
    
    @IBOutlet weak var titleLabel: UILabel! {
        didSet {
            titleLabel.backgroundColor = .black
            titleLabel.textColor = .white
            titleLabel.numberOfLines = 0
            titleLabel.sizeToFit()
        }
    }
    
    override var isSelected: Bool {
        didSet {
            selectedStyle()
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    func setupCell(movie: Movie) {
        titleLabel.text = movie.title
        DispatchQueue.main.async {
            self.image = UIImage(data: movie.image)
            self.posterView.image = self.image
        }
        
    }
    
    @discardableResult
    func selectedStyle() -> Bool {
        backgroundColor = isSelected == true ? .orange : .darkGray
        layer.borderWidth = isSelected == true ? 2.0 : 1.0
        layer.borderColor = UIColor.black.cgColor
        posterView.isHidden = isSelected
        return isSelected
    }
    
    func outlineCell(cell: MovieCell) {
        cell.layer.borderColor = UIColor.white.cgColor
    }
}
