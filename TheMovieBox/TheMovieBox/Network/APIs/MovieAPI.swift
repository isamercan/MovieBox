//
//  MovieAPI.swift
//  TheMovieBox
//
//  Created by isa Mercan on 21.12.2022.
//

import Foundation
protocol MovieAPIProtocol {
    func getMovieDetail(movieId: String, completion: @escaping (Result<MovieModel?, Error>) -> Void)
    func getMovieReviews(movieId: String, completion: @escaping (Result<ReviewsResponseModel?, Error>) -> Void)
    func getSimilarMovies(movieId: String, completion: @escaping (Result<MoviesResponseModel?, Error>) -> Void)
}

class MovieAPI: MovieAPIProtocol {
    private let client: ClientProtocol
    
    init(client: ClientProtocol = Client()) {
        self.client = client
    }
    
    func getMovieDetail(movieId: String, completion: @escaping (Result<MovieModel?, Error>) -> Void) {
        client.makeRequestWithData(route: Router.movieDetail(id: movieId), response: MovieModel.self) { result in
            completion(result)
        }
    }
    
    func getMovieReviews(movieId: String, completion: @escaping (Result<ReviewsResponseModel?, Error>) -> Void) {
        client.makeRequestWithData(route: Router.movieReviews(id: movieId), response: ReviewsResponseModel.self) { result in
            completion(result)
        }
    }
    
    func getSimilarMovies(movieId: String, completion: @escaping (Result<MoviesResponseModel?, Error>) -> Void) {
        client.makeRequestWithData(route: Router.similarMovies(id: movieId), response: MoviesResponseModel.self) { result in
            completion(result)
        }
    }
}
