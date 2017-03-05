//
//  Movie.swift
//  MovieSearch
//
//  Created by Christopher Webb-Orenstein on 2/28/17.
//  Copyright © 2017 Christopher Webb-Orenstein. All rights reserved.
//

import UIKit
import RealmSwift

protocol UserProtocol {
    var username: String { get set }
    var uid: String { get set }
    var firstName: String { get set }
    var lastName: String { get set }
    var joinDate: String { get set }
    var favoriteMovies: List<Movie> { get set }
}

class MovieUser: Object, UserProtocol {
    dynamic var username = ""
    dynamic var uid = ""
    dynamic var firstName = ""
    dynamic var lastName = ""
    dynamic var joinDate = ""
    var favoriteMovies = List<Movie>()
}

class RealmString : Object {
    dynamic var stringValue = ""
}

class Movie: Object {
    dynamic var title: String = ""
    dynamic var releaseDate: String = ""
    dynamic var imdbID: String = ""
    dynamic var posterImageURL = ""
    dynamic var favorite: Bool = false
    var cast = List<RealmString>()
}

