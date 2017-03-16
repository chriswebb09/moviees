//
//  MovieCollectionViewCell.swift
//  MovieSearch
//
//  Created by Christopher Webb-Orenstein on 2/28/17.
//  Copyright © 2017 Christopher Webb-Orenstein. All rights reserved.
//

import UIKit

@IBDesignable
class MovieCell: UICollectionViewCell {
    
    @IBOutlet weak var posterView: UIImageView! {
        didSet {
            posterView.backgroundColor = .gray
        }
    }
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView! {
        didSet {
            activityIndicator.hidesWhenStopped = true
            activityIndicator.color = .white
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
    
    @IBInspectable var borderColor: UIColor = UIColor() {
        didSet {
            layer.borderColor = borderColor.cgColor
        }
    }
    
    @IBInspectable var borderWidth: CGFloat = 0 {
        didSet {
            layer.borderWidth = borderWidth
        }
    }
    
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            layer.cornerRadius = cornerRadius
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
        self.layoutSubviews()
        titleLabel.text = movie.title
        DispatchQueue.main.async {
            self.posterView.image = UIImage(data: movie.image)
        }
        layoutIfNeeded()
    }
    
    @discardableResult
    func selectedStyle() -> Bool {
        backgroundColor = isSelected == true ? .orange : .darkGray
        posterView.isHidden = isSelected
        return !isSelected
    }
    
    func outlineCell(cell: MovieCell) {
        cell.layer.borderColor = UIColor.white.cgColor
    }
}
