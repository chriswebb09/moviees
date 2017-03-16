//
//  String+Extension.swift
//  MovieSearch
//
//  Created by Christopher Webb-Orenstein on 3/15/17.
//  Copyright © 2017 Christopher Webb-Orenstein. All rights reserved.
//

import Foundation

extension String {
    
    func urlEncodedString() -> String? {
        return self.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
    }
}
