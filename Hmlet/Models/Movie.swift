//
//  Movie.swift
//  Hmlet
//
//  Created by Luke Solomon on 6/20/19.
//  Copyright © 2019 Luke Solomon. All rights reserved.
//

import Foundation

struct Response:Decodable {
    var page:Int
    var total_results:Int
    var total_pages:Int
    var results:[Movie]
}

struct Movie:Codable {
    var vote_count:Int?
    var id:Int
    var video:Bool?
    var vote_average:Float?
    var title:String
    var popularity:Double?
    var poster_path:String?
    var original_language:String?
    var original_title:String?
    var genre_ids:[Int]
    var backdrop_path:String?
    var adult:Bool?
    var overview:String?
    var release_date:String?
}


struct requestToken:Decodable {
    var request_token:String
}

struct SessionToken:Decodable {
    var request_token:String
}


//extension DateFormatter {
//    static let yyyyMMdd: DateFormatter = {
//        let formatter = DateFormatter()
//        formatter.dateFormat = "yyyy-MM-dd"
//        formatter.calendar = Calendar(identifier: .iso8601)
//        formatter.timeZone = TimeZone(secondsFromGMT: 0)
//        formatter.locale = Locale(identifier: "en_US_POSIX")
//        return formatter
//    }()
//}
