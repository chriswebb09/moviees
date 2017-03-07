//
//  File.swift
//  MovieSearch
//
//  Created by Christopher Webb-Orenstein on 3/7/17.
//  Copyright © 2017 Christopher Webb-Orenstein. All rights reserved.
//

import UIKit

@IBDesignable
class NavController: UINavigationController {
    
    @IBInspectable var attributedText: [String: Any] {
        didSet {
            navigationBar.titleTextAttributes = attributedText as [String: Any]
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.attributedText = [NSFontAttributeName: "Helvetica"]
        super.init(coder: aDecoder)
        
        print("unable")
        
    }
}
