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
    
    var title:String
    var year:Int
    
    
    init(json:JSON) {
        self.title = json["text"]["name"].stringValue
        self.year = json["text"]["year"].intValue
        
    }
    
    
}
