//
//  SearchField.swift
//  MovieSearch
//
//  Created by Christopher Webb-Orenstein on 3/6/17.
//  Copyright © 2017 Christopher Webb-Orenstein. All rights reserved.
//

import UIKit

@IBDesignable
class SearchField: UITextField {
    
    @IBInspectable var placeholderString: String = "" {
        didSet {
            placeholder = placeholderString
        }
    }
    
    @IBInspectable var border: UIColor = UIColor() {
        didSet {
            layer.borderColor = border.cgColor
        }
    }
    
    @IBInspectable var width: CGFloat = 0 {
        didSet {
            layer.borderWidth = width 
        }
    }
    
    @IBInspectable var radius: CGFloat = 0 {
        didSet {
            layer.cornerRadius = radius
        }
    }

}
