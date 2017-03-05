//
//  MovieButton.swift
//  MovieSearch
//
//  Created by Christopher Webb-Orenstein on 3/4/17.
//  Copyright © 2017 Christopher Webb-Orenstein. All rights reserved.
//

import UIKit

class SearchButton: UIButton {
    
    @IBInspectable var roundedButton: Bool {
        didSet {
            layer.cornerRadius = 4
            backgroundColor = .blue
            setTitleColor(.white, for: .normal)
        }
    }
    
    override init(frame: CGRect) {
        self.roundedButton = true
        super.init(frame: frame)
        self.frame = frame
    }
    
    
    required init?(coder aDecoder: NSCoder? = nil) {
        self.roundedButton = true
        
        if let coder = aDecoder {
            super.init(coder: coder)!
        } else {
            super.init()
        }
    }
}
