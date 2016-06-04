//
//  MovieTableViewCell.swift
//  MovieSearch
//
//  Created by Kevin Hartley on 6/3/16.
//  Copyright © 2016 DevMountain. All rights reserved.
//

import UIKit

class MovieTableViewCell: UITableViewCell {
    
    @IBOutlet weak var movieTitle: UILabel!
    
    @IBOutlet weak var movieRating: UILabel!
    
    @IBOutlet weak var movieOverview: UITextView!
    
    
    
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
