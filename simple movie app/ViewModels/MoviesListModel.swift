//
//  MoviesListModel.swift
//  simple movie app
//
//  Created by Abderrahman Ajid on 9/3/2022.
//

import Foundation
import Combine

protocol MoviesListDelegate: AnyObject {
    func onSuccess()
    func onError(message: String)
}

final class MoviesListModel {
    
    weak var delegate: MoviesListDelegate?
    
    private var cancellable: AnyCancellable?
    
    private let apiFetcher: APIFetching
    
    private(set) var movies: [Movie] = []
    
    private var totalPages: Int = 0
    
    private var currrentPage: Int = 0
    
    init(apiFetcher: APIFetching) {
        self.apiFetcher = apiFetcher
    }
    
    var shouldLoadMore: Bool {
        return currrentPage < totalPages
    }
    
    public func fetchMovies() {
        cancellable = apiFetcher.fetch(
            endPoint: .trendingMovies(page: currrentPage + 1)
        )
            .decode(type: Movies.self, decoder: JSONDecoder())
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    self.delegate?.onError(message: error.localizedDescription)
                }
            }, receiveValue: { movies in
                self.currrentPage = movies.page
                self.totalPages = movies.totalPages
                self.movies.append(contentsOf: movies.results)
                self.delegate?.onSuccess()
            })
    }
    
    func cancel() {
        cancellable = nil
    }
    
}
