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
    static let apiKeyString: String = "f83783c7c1e09d03fe09770bc9c4bf57"
    
    static var myMovies: [Movie] = []
    
    static func getMovies(movieName: String, completion: (movies: [Movie]) -> Void) {
        guard let unwrappedUrl = baseUrl else {
            fatalError("URL not unwrapped")
        }
        
//        let urlParameters = ["api_key=\(apiKeyString)&query=": "\(movieName)"]
        let urlParameters = ["api_key": apiKeyString, "query": movieName]
        
                NetworkController.performRequestForURL(unwrappedUrl, httpMethod: .Get, urlParameters: urlParameters, body: nil) { (data, error) in
                    guard let unwrappedData = data,
                        jsonAnyObject = try? NSJSONSerialization.JSONObjectWithData(unwrappedData, options: .AllowFragments),
                        jsonDictionary = jsonAnyObject as? [String: AnyObject],
                        movieDictionary = jsonDictionary["results"] as? [[String: AnyObject]] else {
                                completion(movies: [])
                            print("nada")
                                return
                    }
                    let moviesArray = movieDictionary.flatMap({Movie(dictionary: $0)})
                    if let movie = Movie(dictionary: jsonDictionary) {
                    myMovies.append(movie)
                    dispatch_get_main_queue()
                    }
                    print("movies: \(myMovies)")
                    completion(movies: moviesArray)
                }
            }
        }

        //["api_key=" + apiKeyString + "&query=": "\(movieName)"]
        
//        NetworkController.performRequestForURL(unwrappedUrl, httpMethod: .Get, urlParameters: urlParameters, body: nil) { (data, error) in
//            if let data = data,
//                let jsonAnyObject = try? NSJSONSerialization.JSONObjectWithData(data, options: []),
//                let jsonDictionary = jsonAnyObject as? [String: AnyObject],
//                let resultsArray = jsonDictionary["results"] as? [[String: AnyObject]] {
//                
//                var movies = [Movie]()
//                for resultDictionary in resultsArray {
//                    if let movie = Movie(dictionary: resultDictionary) {
//                        movies.append(movie)
//                    }
//                }
//                completion(movies: movies)
//            } else {
//                completion(movies: [])
//            }
//        }
//    }
//}






