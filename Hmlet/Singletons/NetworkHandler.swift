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
    
    static func getMovies(completion: @escaping ([Movie]) -> Void) {
        
        Alamofire.request(apiToContact + "categories/", headers: headers).validate().responseJSON(){ response in
            
            switch response.result {
            case .success:
                if let value = response.result.value {
                    let json = JSON(value)
                    guard let results = json["results"].array else { return }
                    var movies = [Movie]()
                    
                    for i in 0..<results.count {
                        movies.append(Movie.init(json: results[i]))
                    }
                    
                    completion(movies)
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    static func getSearch(_ searchString:String, completion: @escaping ([Movie]) -> Void) {
        
        Alamofire.request( "\(apiToContact)/search/\(searchString)", headers: headers).validate().responseJSON() { response in
            
            switch response.result {
            case .success:
                if let value = response.result.value {
                    let json = JSON(value)
                    var responseArray = [Movie]()
                    
                    if let results = json["events"]["results"].array {
                        for i in 0..<results.count {
                            let event = Movie.init(json: results[i])
                            responseArray.append(event)
                        }
                    }
                    
                    completion(responseArray)
                }
            case .failure(let error):
                print(error)
            }
        }
    }

    
    
    
    
}
