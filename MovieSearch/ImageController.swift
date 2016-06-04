//
//  imageController.swift
//  MovieSearch
//
//  Created by Kevin Hartley on 6/3/16.
//  Copyright © 2016 DevMountain. All rights reserved.
//

import UIKit

class ImageController {
    
    // Complete with the image at the url
    static func imageForUrl(urlString: String, completion: (image: UIImage?) -> Void) {
        guard let url = NSURL(string: urlString) else {
            fatalError("Image URL optional is nil")
        }
        NetworkController.performRequestForURL(url, httpMethod: .Get) { (data, error) in
            guard let data = data else {
                completion(image: nil)
                return
            }
            dispatch_async(dispatch_get_main_queue(), {
                completion(image: UIImage(data: data))
            })
        }
    }
}