//
//  EndPoint.swift
//  simple movie app
//
//  Created by Abderrahman Ajid on 9/3/2022.
//

import Foundation

enum HTTPMethod: String {
    case GET, POST, PUT, DELETE
}

private struct APIKey {
    static let value = "c9856d0cb57c3f14bf75bdc6c063b8f3"
}

public enum EndPoints {
    case trendingMovies(page: Int)
    case movieDetails(identifier: Int)
}
extension EndPoints {
    var url: URL? {
        components.url
    }
}
extension EndPoints {
    var httpMethod: HTTPMethod {
        .GET
    }
    private var components: URLComponents {
        var components = URLComponents()
        components.scheme = "https"
        components.host = baseURL
        components.path = path
        components.queryItems = queries
        return components
    }
    private var baseURL: String {
        "api.themoviedb.org"
    }
    private var queries: [URLQueryItem] {
        let apiKeyQuey = URLQueryItem(name: "api_key", value: APIKey.value)
        switch self {
        case .trendingMovies(let page):
            let pageQuery = URLQueryItem(name: "page", value: String(page))
            return [apiKeyQuey, pageQuery]
        case .movieDetails(let identifier): return [apiKeyQuey]
        }
    }
    private var path: String {
        switch self {
        case .trendingMovies: return "/3/discover/movie"
        case .movieDetails(let movieId): return "/3/movies/\(movieId)"
        }
    }
}

