//
//  MovieButton.swift
//  MovieSearch
//
//  Created by Christopher Webb-Orenstein on 3/4/17.
//  Copyright © 2017 Christopher Webb-Orenstein. All rights reserved.
//

import UIKit

@IBDesignable
class SearchButton: UIButton {
    
    @IBInspectable var roundedButton: Bool {
        didSet {
            layer.cornerRadius = 4
            backgroundColor = .blue
            setTitleColor(.white, for: .normal)
        }
    }
    
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }
    
    @IBInspectable var borderWidth: CGFloat = 0 {
        didSet {
            layer.borderWidth = borderWidth
        }
    }
    
    @IBInspectable var borderColor: UIColor? {
        didSet {
            layer.borderColor = borderColor?.cgColor
        }
    }
    
    override init(frame: CGRect) {
        roundedButton = true
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder? = nil) {
        roundedButton = true
        if let coder = aDecoder {
            super.init(coder: coder)!
        } else {
            super.init()
        }
    }
}
