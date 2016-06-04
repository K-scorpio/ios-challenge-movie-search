//
//  MovieController.swift
//  MovieSearch
//
//  Created by Kevin Hartley on 6/3/16.
//  Copyright © 2016 DevMountain. All rights reserved.
//

import Foundation

class MovieController {

    static let baseUrl = NSURL(string: "http://api.themoviedb.org/3/search/movie?api_key=f83783c7c1e09d03fe09770bc9c4bf57&query=/")
    
    var myMovies: [Movie] = []

    static func getMovies(completion: (movies: [Movie]) -> Void) {
        guard let unwrappedUrl = baseUrl else {
            fatalError("URL not unwrapped")
        }
        NetworkController.performRequestForURL(unwrappedUrl, httpMethod: .Get) { (data, error) in
            guard let data = data,
                jsonAnyObject = try? NSJSONSerialization.JSONObjectWithData(data, options: .AllowFragments),
                jsonDictionary = jsonAnyObject as? [String: AnyObject],
                movieDictionary = jsonDictionary["movies"] as? [[String: AnyObject]] else {
                        completion(movies: [])
                        return
            }
            let moviesArray = movieDictionary.flatMap({Movie(dictionary: $0)})
            completion(movies: moviesArray)
        }
    }
}