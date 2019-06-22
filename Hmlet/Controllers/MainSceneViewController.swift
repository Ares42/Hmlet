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
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: - Variables
    var movieArray = [Movie]()
    
    
    //MARK: - View LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dispatchMain()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
    }
    
    
    //MARK: - Data Handler
    func requestMovies() {
        
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            guard let self = self else {
                return
            }
            if let safeMovies = NetworkHandler.getMovies(completion: ([Movie]) -> Void) {
                self.movieArray = safeMovies
            }
            

            DispatchQueue.main.async { [weak self] in
                self?.tableView.reloadData()
            }
        }
        

    }
    
    
    
}

extension MainSceneViewController:UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "movieCell", for: <#T##IndexPath#>)
    }
    
    
}

extension MainSceneViewController:UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}
