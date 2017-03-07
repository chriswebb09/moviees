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
    
    @IBInspectable var tintColor: UIColor = UIColor() {
        didSet {
            navigationBar.tintColor = tintColor
        }
    }
    
    @IBInspectable var topItemColor: UIColor = UIColor() {
        didSet {
            navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: topItemColor]
        }
    }
    
    @IBInspectable var barColor: UIColor = UIColor() {
        didSet {
            navigationBar.barTintColor = barColor
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.attributedText = [NSFontAttributeName: "Helvetica"]
        super.init(coder: aDecoder)
        
        print("unable")
        
    }
}
