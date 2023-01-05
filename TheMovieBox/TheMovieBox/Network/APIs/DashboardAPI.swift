//
//  DashboardAPI.swift
//  TheMovieBox
//
//  Created by isa Mercan on 21.12.2022.
//

import Foundation

protocol DashboardAPIProtocol {
    func getMostPopularMovies(completion: @escaping (Result<MoviesResponseModel?, Error>) -> Void)
    func getHighlyRatedMovies(completion: @escaping (Result<MoviesResponseModel?, Error>) -> Void)
    func getUpcomingMovies(completion: @escaping (Result<MoviesResponseModel?, Error>) -> Void)
}


class DashboardAPI: DashboardAPIProtocol {
    private let client: ClientProtocol
    
    init(client: ClientProtocol = Client()) {
        self.client = client
    }
    
    func getMostPopularMovies(completion: @escaping (Result<MoviesResponseModel?, Error>) -> Void) {
        client.makeRequestWithData(route: Router.popularMovies, response: MoviesResponseModel.self) { result in
            completion(result)
        }
    }
    
    func getHighlyRatedMovies(completion: @escaping (Result<MoviesResponseModel?, Error>) -> Void) {
        client.makeRequestWithData(route: Router.highlyRatedMovies, response: MoviesResponseModel.self) { result in
            completion(result)
        }
    }
    
    func getUpcomingMovies(completion: @escaping (Result<MoviesResponseModel?, Error>) -> Void) {
        client.makeRequestWithData(route: Router.upcomingMovies, response: MoviesResponseModel.self) { result in
            completion(result)
        }
    }
}
