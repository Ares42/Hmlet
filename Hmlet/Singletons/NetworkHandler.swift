//
//  NetworkHandler.swift
//  Hmlet
//
//  Created by Luke Solomon on 6/20/19.
//  Copyright © 2019 Luke Solomon. All rights reserved.
//

import Foundation
import Alamofire


let apiToContact = "https://api.themoviedb.org/3"
let APIKEY = "?api_key=3aeab01116efcce4cd7a822e7a210768"

let imageBasePath = "https://image.tmdb.org/t/p/w185"

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
    
    
    func constructRequest() {
        // given a set of parameters, constructs an actual Get Request. Should this be abstracted later? probably. Let's see what we build and what we need.
    }
    
    
    static func getPopularMovies(completion: @escaping ([Movie]) -> Void) {
        
        Alamofire.request("\(apiToContact)/movie/popular\(APIKEY)",
                          method: .get
            ).validate().responseJSON() { response in
                            
            switch response.result {
            case .success:
                guard let data = response.data else { return }
                do {
                    let decoder = JSONDecoder()
                    decoder.dateDecodingStrategy = .iso8601
                    let moviesResponse = try decoder.decode(Response.self, from: data)
                    print(moviesResponse)
                    completion(moviesResponse.results)
                } catch let jsonErr {
                    print("Error serializing Json \(jsonErr)")
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    

    
    static func getSearch(_ searchString:String, completion: @escaping ([Movie]) -> Void) {

        Alamofire.request( "\(apiToContact)/search/movie\(APIKEY)&query=\(searchString)",
            method: .get
            ).validate().responseJSON() { response in

            switch response.result {
            case .success:
                guard let data = response.data else { return }
                do {
                    let decoder = JSONDecoder()
                    decoder.dateDecodingStrategy = .iso8601
                    let moviesResponse = try decoder.decode(Response.self, from: data)
                    print(moviesResponse)
                    completion(moviesResponse.results)
                } catch let jsonErr {
                    print("Error serializing Json \(jsonErr)")
                }
            case .failure(let error):
                print(error)
            }
        }
    }

    func getSession() {
        
    }
    
    static func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    
    
    
}

extension UIImageView {
    func downloaded(from url: URL, contentMode mode: UIView.ContentMode = .scaleAspectFit) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() {
                self.image = image
            }
            }.resume()
    }
    
    func downloaded(from link: String, contentMode mode: UIView.ContentMode = .scaleAspectFit) {
        let fullPath = "\(imageBasePath)\(link)"
        
        guard let url = URL(string: fullPath) else { return }
        downloaded(from: url, contentMode: mode)
    }
}
