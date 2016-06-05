//
//  movie.swift
//  MovieSearch  //
//  Created by Kevin Hartley on 6/3/16.
//  Copyright © 2016 DevMountain. All rights reserved.
//

import Foundation

class Movie {
    
    private let kTitle = "title"
    private let kRating = "vote_average"
    private let kOverview = "overview"
    private let kImageString = "poster_path"
    
    let title: String
    let rating: String
    let overview: String
    let imageString: String
    
    init?(dictionary: [String: AnyObject]) {
        guard let title = dictionary[kTitle] as? String,
            rating = dictionary[kRating] as? String,
            overview = dictionary[kOverview] as? String,
            imageString = dictionary[kImageString] as? String else {
                return nil
        }
        self.title = title
        self.rating = rating
        self.overview = overview
        self.imageString = imageString
    }
}
