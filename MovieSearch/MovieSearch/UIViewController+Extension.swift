//
//  UIViewController+Extension.swift
//  MovieSearch
//
//  Created by Christopher Webb-Orenstein on 3/8/17.
//  Copyright © 2017 Christopher Webb-Orenstein. All rights reserved.
//

import UIKit


extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
}
