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
    }
    
    
    //MARK: - Data Handler
    func updateTableView() {
        if let text = self.searchField.text {
            self.activityIndicator.startAnimating()
            self.activityIndicator.isHidden = false

            guard let searchBarEncodedText = text.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlHostAllowed) else { return }
            
            NetworkHandler.getSearch(searchBarEncodedText, completion: { (responseArray) -> Void in
                self.movieArray = responseArray
                self.activityIndicator.isHidden = true
                self.activityIndicator.stopAnimating()
                self.tableView.reloadData()
            })
        }
    }
    
    //MARK: - IBActions
    @IBAction func editingChanged(_ sender: Any) {
        self.activityIndicator.isHidden = false
        self.activityIndicator.startAnimating()
        
        updateTableView()
    }
    
}

extension MainSceneViewController:UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "movieCell", for: indexPath) as! MovieCell
        
        return cell
    }
    
    
}

extension MainSceneViewController:UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}

