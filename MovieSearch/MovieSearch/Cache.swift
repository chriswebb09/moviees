//
//  Cache.swift
//  MovieSearch
//
//  Created by Christopher Webb-Orenstein on 3/15/17.
//  Copyright © 2017 Christopher Webb-Orenstein. All rights reserved.
//

import UIKit

struct Cache {
    
    let imageCache = NSCache<NSString, UIImage>()
    
    
    func getCacheImage(urlString: String) -> UIImage? {
        if let cachedImage = imageCache.object(forKey: urlString as NSString) {
            return cachedImage
        }
        return nil
    }
    
}

