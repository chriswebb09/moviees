//
//  UICollectionViewController+Extension.swift
//  MovieSearch
//
//  Created by Christopher Webb-Orenstein on 3/9/17.
//  Copyright © 2017 Christopher Webb-Orenstein. All rights reserved.
//

import UIKit

extension UICollectionViewController {
    
    override open func viewDidLoad() {
        edgesForExtendedLayout = []
        collectionView?.delegate = self
        collectionView?.dataSource = self
        definesPresentationContext = true
        collectionView?.backgroundColor = .lightGray
        super.viewDidLoad()
    }
}

extension UICollectionViewController {
    
    func returnHeaderView(_ indexPath: IndexPath) -> HeaderReusableView {
        let reusableview = collectionView?.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier:  "CollectionViewHeader", for: indexPath) as! HeaderReusableView
        reusableview.frame = CGRect(x:0 , y:0, width: self.view.frame.width, height:50)
        return reusableview
    }
    
    func hideKeyboardWhenTapped(tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard(end:)))) -> Bool {
        view.addGestureRecognizer(tap)
        return true
    }
    
    func dismissKeyboard(end: Bool) -> Bool {
        view.endEditing(end)
        return end
    }
}
