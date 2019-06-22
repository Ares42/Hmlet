//
//  Movie.swift
//  Hmlet
//
//  Created by Luke Solomon on 6/20/19.
//  Copyright © 2019 Luke Solomon. All rights reserved.
//

import Foundation
import SwiftyJSON


struct Movie {
    
    var posterURL:NSURL
    var title:String
    var year:Int
    var rating:Double
    
    
    init(json:JSON) {
        if let safeURL = NSURL.init(string: json["poster_path"].stringValue) {
            self.posterURL = safeURL
        } else {
            print("poster fetch failure")
            self.posterURL = NSURL.init()
        }
        
        self.title = json["title"].stringValue
        self.year = json["release_date"].intValue
        self.rating = json["vote_average"].doubleValue
    }
    
    
}
