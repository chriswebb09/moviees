//
//  DataParser.swift
//  MovieSearch
//
//  Created by Christopher Webb-Orenstein on 3/6/17.
//  Copyright © 2017 Christopher Webb-Orenstein. All rights reserved.
//

import UIKit

class DataParser {
    
    func parseData(data: [[String: String]]) -> [Movie] {
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
                allMovies.append(movie)
            }
        }
        return allMovies
    }
}
 
