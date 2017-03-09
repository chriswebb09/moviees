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
    
    
    @IBInspectable var backgroundTint: UIColor = UIColor() {
        didSet {
            backgroundColor = backgroundTint
        }
    }

    @IBInspectable var placeHolderColor: UIColor? {
        get {
            return self.placeHolderColor
        }
        set {
            self.attributedPlaceholder = NSAttributedString(string:self.placeholder != nil ? self.placeholder! : "", attributes:[NSForegroundColorAttributeName: newValue!])
        }
    }
    
    @IBInspectable var radius: CGFloat = 0 {
        didSet {
            layer.cornerRadius = radius
        }
    }
    
    @IBInspectable var textTint: UIColor = UIColor() {
        didSet {
            textColor = textTint
        }
    }
    
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return CGRect(x: bounds.origin.x + 15,
                      y: bounds.origin.y,
                      width: bounds.width + 15,
                      height: bounds.height)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return CGRect(x: bounds.origin.x + 15,
                      y: bounds.origin.y,
                      width: bounds.width + 15,
                      height: bounds.height)
    }
}
