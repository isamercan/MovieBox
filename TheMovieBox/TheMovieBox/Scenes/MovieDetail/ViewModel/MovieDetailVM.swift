//
//  MovieDetailVM.swift
//  TheMovieBox
//
//  Created by isa Mercan on 21.12.2022.
//

import Foundation
enum MovieDetailCellType {
    case empty
    case header(model: MovieModel)
    case info
    case similarMovies(items: [MovieModel])
    case reviewTitle(title : String)
    case reviews(items: [Review])
}

class MovieDetailVM {
    var cellTypes: [MovieDetailCellType] = []
    var api = MovieAPI()
    var selectedMovieId: Int!
    var movie: MovieModel?
    var similarMovies: [MovieModel] = []
    var favoriteMovies: [MovieModel] = []
    var reviews: [Review] = []
    var showAlertClosure: ((String) -> Void)?
    var reloadDataClosure: (() -> Void)?
    
    var alertMessage: String? {
        didSet {
            if let msg = self.alertMessage {
                self.showAlertClosure?(msg)
            }
        }
    }
    init(movieId: Int) {
        selectedMovieId = movieId
        getFavoriteMovies()
    }
    
    func updateFeed() {
        if cellTypes.count == 0 {
            cellTypes.append(.empty)
        }
        reloadDataClosure?()
    }
        
    func getMovieDetail() {
        cellTypes.removeAll()
        api.getMovieDetail(movieId: "\(selectedMovieId ?? 0)") { [weak self] (results, error) in
            guard let self = self, error == nil, let movie = results else {
                self?.alertMessage = error?.localizedDescription ?? ""
                self?.updateFeed()
                return
            }
            self.movie = movie
            self.cellTypes.append(.header(model: movie))
            self.getSimilarMovies()
        }
    }
    
    func getSimilarMovies() {
        guard let id = selectedMovieId else { return }
        api.getSimilarMovies(movieId: String(id)) { [weak self] (results, error) in
            guard let self = self, error == nil, let movies = results, movies.count > 0 else {
                self?.alertMessage = error?.localizedDescription ?? ""
                self?.updateFeed()
                return
            }
            self.cellTypes.append(.similarMovies(items: movies))
            self.similarMovies = movies
            self.getMovieReviews()
        }
    }
    
    
    func getMovieReviews() {
        guard let id = selectedMovieId else { return }
        api.getMovieReviews(movieId: String(id)) { [weak self] (results, error) in
            guard let self = self, error == nil, let reviews = results, reviews.count > 0 else {
                self?.alertMessage = error?.localizedDescription ?? ""
                self?.updateFeed()
                return
            }
            self.cellTypes.append(.reviewTitle(title: "Reviews"))
            self.cellTypes.append(.reviews(items: reviews))
            self.reviews = reviews
            self.updateFeed()
        }
    }
    
    func getFavoriteMovies() {
        let movies = UserDefaultsManager.shared.getStoredMovies(forKey: .FavoriteMovies)
        guard movies.count > 0 else {
            return
        }
        self.favoriteMovies = movies
    }
    
}
