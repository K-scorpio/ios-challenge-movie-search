//
//  MovieController.swift
//  MovieSearch
//
//  Created by Kevin Hartley on 6/3/16.
//  Copyright © 2016 DevMountain. All rights reserved.
//

import Foundation

class MovieController {

    static let baseUrl = NSURL(string: "http://api.themoviedb.org/3/search/movie?")
    static let apiKeyString = "f83783c7c1e09d03fe09770bc9c4bf57"
    
//    var myMovies: [Movie] = []

    static func getMovies(movieName: String, completion: (movies: [Movie]) -> Void) {
        guard let unwrappedUrl = baseUrl else {
            fatalError("URL not unwrapped")
        }
        
        let urlParameters = ["api_key=" + apiKeyString + "&query=": "\(movieName)"]
        NetworkController.performRequestForURL(unwrappedUrl, httpMethod: .Get, urlParameters: urlParameters) { (data, error) in
            guard let data = data,
                jsonAnyObject = try? NSJSONSerialization.JSONObjectWithData(data, options: .AllowFragments),
                jsonDictionary = jsonAnyObject as? [String: AnyObject],
                movieDictionary = jsonDictionary["results"] as? [[String: AnyObject]] else {
                        completion(movies: [])
                        return
            }
            let moviesArray = movieDictionary.flatMap({Movie(dictionary: $0)})
            completion(movies: moviesArray)
        }
    }
}