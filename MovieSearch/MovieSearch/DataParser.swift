//
//  DataParser.swift
//  MovieSearch
//
//  Created by Christopher Webb-Orenstein on 3/6/17.
//  Copyright © 2017 Christopher Webb-Orenstein. All rights reserved.
//

import UIKit
import Realm
import RealmSwift

class DataParser {
    
    func parseData(data: [[String: String]]) {
        var movies: Results<Movie>!
        var allMovies = [Movie]()
        
        data.forEach { [weak self] finalData in
            if finalData["Type"] == "movie" {
                guard let title = finalData["Title"] else { return }
                guard let year = finalData["Year"] else { return }
                guard let imdbID = finalData["imdbID"] else { return }
                guard let posterURL = finalData["Poster"] else { return }
                let movie = Movie(title: title,
                                  year: year,
                                  director: "none",
                                  cast: ["NONE"],
                                  genre: ["NONE"],
                                  imdbID: imdbID,
                                  posterURL: posterURL)
                APIClient().downloadImage(url: URL(string:posterURL)!, handler: { image in
                    movie.image = NSData(data: UIImageJPEGRepresentation(image,0.9)!) as! Data
                    if let realm = try? Realm() {
                        movies = realm.objects(Movie.self)
                        if !(movies.contains(movie)) {
                            try! realm.write {
                                realm.add(movie)
                            }
                            allMovies.append(movie)
                           // realm.refresh()
                        }
                        realm.refresh()
                    }
                    
                })
                
                
            }
        }
    }
}
