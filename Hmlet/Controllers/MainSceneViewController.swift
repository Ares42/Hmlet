//
//  MainSceneViewController.swift
//  Hmlet
//
//  Created by Luke Solomon on 6/17/19.
//  Copyright © 2019 Luke Solomon. All rights reserved.
//

import UIKit


class MainSceneViewController:UIViewController {

    //MARK: - IBOutlets
    @IBOutlet var searchField: UITextField!
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    @IBOutlet var tableView: UITableView!
    
    //MARK: - Variables
    var movieArray = [Movie]()
    
    
    //MARK: - View LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.activityIndicator.isHidden = true
        self.activityIndicator.stopAnimating()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        self.tableView.reloadData()
    }
    
    //MARK: - Interface updates
    func updateTableView() {
        self.activityIndicator.isHidden = true
        self.activityIndicator.stopAnimating()
        self.tableView.reloadData()
    }
    
    //MARK: - IBActions
    @IBAction func editingChanged(_ sender: Any) {
        self.activityIndicator.isHidden = false
        self.activityIndicator.startAnimating()
        
        if let safeSearchText = searchField.text,
            let searchBarEncodedText = safeSearchText.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlHostAllowed) {
            NetworkHandler.getSearch(searchBarEncodedText, completion: { (responseArray) -> Void in
                self.movieArray = responseArray
                
                DispatchQueue.main.async {
                    self.updateTableView()
                }
            })
        }
    }
    
}

extension MainSceneViewController:UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "movieCell", for: indexPath) as! MovieCell
        
        let movie = movieArray[indexPath.row]
        
        cell.movieTitleLabel.text = movie.title
        cell.ratingLabel.text = String("\(movie.vote_average)")
        cell.yearLabel.text = movie.release_date
        cell.overviewText.text = movie.overview
        cell.overviewText.sizeToFit()
        if let url = movie.poster_path {
            cell.posterView.downloaded(from: url, contentMode: .scaleAspectFill)
        }
        
        return cell
    }    

}

extension MainSceneViewController:UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
}


