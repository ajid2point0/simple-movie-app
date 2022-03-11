//
//  Movie.swift
//  simple movie app
//
//  Created by Abderrahman Ajid on 9/3/2022.
//

import Foundation

struct Movies: Decodable {
    
    var page: Int
    var results: [Movie]
    var totalPages: Int
    
    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
    }
    
}

struct Movie: Decodable {
    
    var identifier: Int
    var title: String
    var overview: String?
    var posterPath: String?
    var releasDate: String
    
    enum CodingKeys: String, CodingKey {
        case identifier = "id"
        case title, overview
        case posterPath = "poster_path"
        case releasDate = "release_date"
    }
    
}
