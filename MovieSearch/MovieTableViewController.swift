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
    var movieSearchResult = [Movie]()

    @IBOutlet var movieTableView: UITableView!
    
//    init() {
//    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        searchBar.delegate = self
    }


    // MARK: - Table view data source

//    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 0
//    }

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */
    
    @IBOutlet weak var searchBar: UISearchBar!
    
        var searchActive : Bool = false
        var data = ["\(searchBarSearchButtonClicked)"]
        var filtered:[String] = []
    
        func searchBarTextDidBeginEditing(searchBar: UISearchBar) {
            searchActive = true;
        }
        
        func searchBarTextDidEndEditing(searchBar: UISearchBar) {
            searchActive = false;
        }
        
        func searchBarCancelButtonClicked(searchBar: UISearchBar) {
            searchActive = false;
        }
        
        func searchBarSearchButtonClicked(searchBar: UISearchBar) {
            let searchText = searchBar.text ?? ""
            MovieController.getMovies(searchText) { (movies) in
                self.movieSearchResult = movies
                self.tableView.reloadData()
            }
            searchActive = false;
        }
        
        func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
            
            filtered = data.filter({ (text) -> Bool in
                let tmp: NSString = text
                let range = tmp.rangeOfString(searchText, options: NSStringCompareOptions.CaseInsensitiveSearch)
                return range.location != NSNotFound
            })
            if(filtered.count == 0){
                searchActive = false;
            } else {
                searchActive = true;
            }
            self.tableView.reloadData()
        }
        
        
        override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            if(searchActive) {
                return filtered.count
            }
            return data.count;
        }
    
        override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
            guard let cell = tableView.dequeueReusableCellWithIdentifier("movieCell") as? MovieTableViewCell else {
                return UITableViewCell()
            }
            let movie = movieSearchResult[indexPath.row]
            
            cell.movieTitle.text = movie.title
            cell.movieRating.text = movie.rating
            cell.movieOverview.text = movie.overview
            cell.moviePoster.image = UIImage(contentsOfFile: movie.imageString)
            
            
            if(searchActive){
                cell.textLabel?.text = filtered[indexPath.row]
            } else {
                cell.textLabel?.text = data[indexPath.row];
            }
            
            return cell
        }
    }
