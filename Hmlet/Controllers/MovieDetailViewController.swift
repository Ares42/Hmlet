//
//  MovieDetailViewController.swift
//  Hmlet
//
//  Created by Luke Solomon on 6/17/19.
//  Copyright © 2019 Luke Solomon. All rights reserved.
//

import UIKit


class MovieDetailViewController:UIViewController {
    
    // IBOutlets
    @IBOutlet weak var testAPIButton: UIButton!
    @IBOutlet weak var resultsTextView: UITextView!
    
    
    
    
    // IBActions
    @IBAction func testApiCallButtonTapped(_ sender: Any) {
        
        
        NetworkHandler.getPopularMovies { (movieArray) in
            DispatchQueue.main.async { [weak self] in
                guard let safeSelf = self else {return}
                safeSelf.updateTextViewWithMovies(movieArray: movieArray)
            }
        }
    }
    
    func updateTextViewWithMovies(movieArray:[Movie]) {
        
        self.resultsTextView.text = "\(movieArray)"
        
    }
    
    
}
