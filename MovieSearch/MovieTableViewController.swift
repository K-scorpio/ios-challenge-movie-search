//
//  MovieTableViewController.swift
//  MovieSearch
//
//  Created by Kevin Hartley on 6/3/16.
//  Copyright © 2016 DevMountain. All rights reserved.
//

import UIKit

class MovieTableViewController: UITableViewController, UISearchBarDelegate {
    
    var movieController = MovieController()
    var movieSearchResults = [Movie]()
    
    @IBOutlet var movieTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.reloadData()
    }
    
    
    // MARK: - Table view data source
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        let searchText = searchBar.text ?? ""
        MovieController.getMovies(searchText) { (movies) in
            self.movieSearchResults = movies
            self.tableView.reloadData()
        }
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieSearchResults.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCellWithIdentifier("movieCell") as? MovieTableViewCell else {
            return UITableViewCell()
        }
        
        dispatch_sync(dispatch_get_main_queue()) {
            
        let movie = self.movieSearchResults[indexPath.row]

        cell.movieTitle.text = movie.title
        let f = movie.rating
        _ = NSString(format: "%.2f", f)
        let nf = NSNumberFormatter()
        nf.numberStyle = .DecimalStyle
        let s = nf.stringFromNumber(f)
        cell.movieRating.text = s
        cell.movieOverview.text = movie.overview
        ImageController.imageForUrl(movie.imageString, completion: { (image) in
            cell.moviePoster.image
        })
        }

//cell.moviePoster.image =
        
//        UIImage(contentsOfFile: movie.imageString)
        
        return cell
    }
}
