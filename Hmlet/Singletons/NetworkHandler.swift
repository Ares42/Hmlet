//
//  NetworkHandler.swift
//  Hmlet
//
//  Created by Luke Solomon on 6/20/19.
//  Copyright © 2019 Luke Solomon. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON


let apiToContact = "https://api.themoviedb.org/3/movie/550?api_key=\(APIKEY)"
let APIKEY = "3aeab01116efcce4cd7a822e7a210768"
let headers: HTTPHeaders = [
    "Accept": "application/json",
    "x-listing-context": "website-config-id=237",
    "Authorization": "Bearer 4412e623-f1b1-3f21-926c-14ed71e71d61"
]


class NetworkHandler:NSObject {
    
    public static let sharedInstance = NetworkHandler()

    private override init() {
        super.init()
    }
    
    //_ completion: @escaping (Movie) -> Void
    
    static func getMovies() {
        
        
        
        
        Alamofire.request(apiToContact + "categories/", headers: headers).validate().responseJSON(){ response in
            
            switch response.result {
            case .success:
                if let value = response.result.value {
                    let json = JSON(value)
                    
                    let results = Movie.init(json: json)
                    
                    completion(results)
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    
    
    
    
    
    
}
