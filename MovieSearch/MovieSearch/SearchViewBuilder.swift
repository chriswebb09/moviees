//
//  SearchViewBuilder.swift
//  MovieSearch
//
//  Created by Christopher Webb-Orenstein on 3/19/17.
//  Copyright © 2017 Christopher Webb-Orenstein. All rights reserved.
//

import Foundation
import UIKit

public protocol SearchViewBuilder {
    func buildSearchModule() -> UIViewController?
}

