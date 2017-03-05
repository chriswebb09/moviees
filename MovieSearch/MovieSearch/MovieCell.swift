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
    
    @IBOutlet weak var titleLabel: UILabel! {
        didSet {
            titleLabel.backgroundColor = .black
            titleLabel.textColor = .white
            titleLabel.sizeToFit()
        }
    }
    
    override var isSelected: Bool {
        didSet {
            posterView.isHidden = isSelected
            if isSelected {
                backgroundColor = .orange
                selectedStyle()
            }
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        backgroundColor = .darkGray
    }
    
    @discardableResult
    func selectedStyle() -> Bool {
        layer.borderWidth = 2.0
        layer.borderColor = UIColor.black.cgColor
        return isSelected
    }
    
    func outlineCell(cell: MovieCell) {
        cell.layer.borderColor = UIColor.white.cgColor
    }
}
