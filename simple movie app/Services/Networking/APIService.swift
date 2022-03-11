//
//  APIService.swift
//  simple movie app
//
//  Created by Abderrahman Ajid on 9/3/2022.
//

import Foundation
import Combine

enum APIError: Error, LocalizedError {
    case failedRequest, invalidResponse, unreachable, invalidAPIKey, resourceNotFound
    
    var errorDescription: String? {
        switch self {
        case .failedRequest: return "Request Failed, please try again later."
        case .invalidResponse: return "Server response is invalid."
        case .unreachable: return "Request Failed, please verify that you are connected to the internet."
        case .invalidAPIKey: return "Invalid API key: You must be granted a valid key."
        case .resourceNotFound: return "The resource you requested could not be found."
        }
    }
}

protocol APIFetching {
    func fetch(endPoint: EndPoints) -> AnyPublisher<Data, APIError>
}

final class APIFetcher: APIFetching {
    func fetch(endPoint: EndPoints) -> AnyPublisher<Data, APIError> {
        let request = URLRequest(url: endPoint.url!)
        return URLSession.DataTaskPublisher(request: request, session: .shared)
            .tryMap { data, response in
                guard let httpResponse = response as? HTTPURLResponse else {
                    throw APIError.failedRequest
                }
                if httpResponse.statusCode == 401 {
                    throw APIError.invalidAPIKey
                }
                if httpResponse.statusCode == 404 {
                    throw APIError.resourceNotFound
                }
                if 200..<300 ~= httpResponse.statusCode {
                    return data
                }
                throw APIError.failedRequest
            }
            .mapError { error -> APIError in
                switch error {
                case let apiError as APIError:
                    return apiError
                case URLError.notConnectedToInternet:
                    return APIError.unreachable
                default:
                    return APIError.failedRequest
                }
            }
            .eraseToAnyPublisher()
    }
}
