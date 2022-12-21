//
//  MovieAPI.swift
//  TheMovieBox
//
//  Created by isa Mercan on 21.12.2022.
//

import Foundation
protocol MovieAPIProtocol {
    func getMovieDetail(movieId: String, completion: @escaping (_ reviews: MovieModel?, _ error: Error?) -> Void)
    func getMovieReviews(movieId: String, completion: @escaping (_ reviews: [Review]?, _ error: Error?) -> Void)
    func getSimilarMovies(movieId: String, completion: @escaping (_ movies: [MovieModel]?, _ error: Error?) -> Void)
}

class MovieAPI: MovieAPIProtocol {
    private let client: ClientProtocol
    
    init(client: ClientProtocol = Client()) {
        self.client = client
    }
    
    func getMovieDetail(movieId: String, completion: @escaping (MovieModel?, Error?) -> Void) {
        client.makeRequestWithData(route: Router.movieDetail(id: movieId), response: MovieModel.self) { responseData, error in
            guard let response = responseData, error == nil else {
                completion(nil, error)
                return
            }
            completion(response, nil)
        }
    }
    
    func getMovieReviews(movieId: String, completion: @escaping ([Review]?, Error?) -> Void) {
        client.makeRequestWithData(route: Router.movieReviews(id: movieId), response: ReviewsResponseModel.self) { responseData, error in
            guard let response = responseData, error == nil else {
                completion(nil, error)
                return
            }
            completion(response.results, nil)
        }
    }
    
    func getSimilarMovies(movieId: String, completion: @escaping ([MovieModel]?, Error?) -> Void) {
        client.makeRequestWithData(route: Router.similarMovies(id: movieId), response: MoviesResponseModel.self) { responseData, error in
            guard let response = responseData, error == nil else {
                completion(nil, error)
                return
            }
            completion(response.results, nil)
        }
    }
}
