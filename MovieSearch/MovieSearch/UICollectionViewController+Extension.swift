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
        self.edgesForExtendedLayout = []
        self.collectionView?.delegate = self
        self.collectionView?.dataSource = self
        self.definesPresentationContext = true
        self.collectionView?.backgroundColor = .lightGray
        super.viewDidLoad()
    }
}
