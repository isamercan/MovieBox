//
//  DashboardAPI.swift
//  TheMovieBox
//
//  Created by isa Mercan on 21.12.2022.
//

import Foundation

protocol DashboardAPIProtocol {
    func getMostPopularMovies(completion: @escaping (_ movies: [MovieModel]?, _ error: Error?) -> Void)
    func getHighlyRatedMovies(completion: @escaping (_ movies: [MovieModel]?, _ error: Error?) -> Void)
    func getUpcomingMovies(completion: @escaping (_ movies: [MovieModel]?, _ error: Error?) -> Void)
}


class DashboardAPI: DashboardAPIProtocol {
    private let client: ClientProtocol
    
    init(client: ClientProtocol = Client()) {
        self.client = client
    }
    
    func getMostPopularMovies(completion: @escaping ([MovieModel]?, Error?) -> Void) {
        client.makeRequestWithData(route: Router.popularMovies, response: MoviesResponseModel.self) { responseData, error in
            guard let response = responseData, error == nil else {
                completion(nil, error)
                return
            }
            completion(response.results, nil)
        }
    }
    
    func getHighlyRatedMovies(completion: @escaping ([MovieModel]?, Error?) -> Void) {
        client.makeRequestWithData(route: Router.highlyRatedMovies, response: MoviesResponseModel.self) { responseData, error in
            guard let response = responseData, error == nil else {
                completion(nil, error)
                return
            }
            completion(response.results, nil)
        }
    }
    
    func getUpcomingMovies(completion: @escaping ([MovieModel]?, Error?) -> Void) {
        client.makeRequestWithData(route: Router.upcomingMovies, response: MoviesResponseModel.self) { responseData, error in
            guard let response = responseData, error == nil else {
                completion(nil, error)
                return
            }
            completion(response.results, nil)
        }
    }    
}
