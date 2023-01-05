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
        api.getMovieDetail(movieId: "\(selectedMovieId ?? 0)") {[weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let movieDetail):
                if let movie = movieDetail {
                    self.movie = movie
                    self.cellTypes.append(.header(model: movie))
                    self.getSimilarMovies()
                }
            case .failure(let error):
                self.alertMessage = error.localizedDescription
                self.updateFeed()
            }
        }
    }
    
    func getSimilarMovies() {
        guard let id = selectedMovieId else { return }
        api.getSimilarMovies(movieId: String(id)) {[weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let movies):
                if let movies = movies?.results, movies.count > 0 {
                    self.cellTypes.append(.similarMovies(items: movies))
                    self.similarMovies = movies
                    self.getMovieReviews()
                }
            case .failure(let error):
                self.alertMessage = error.localizedDescription
                self.updateFeed()
            }
        }
    }
    
    func getMovieReviews() {
        guard let id = selectedMovieId else { return }
        api.getMovieReviews(movieId: String(id)) {[weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let reviews):
                if let reviews = reviews?.results, reviews.count > 0 {
                    self.cellTypes.append(.reviewTitle(title: "Reviews"))
                    self.cellTypes.append(.reviews(items: reviews))
                    self.reviews = reviews
                }
                self.updateFeed()
            case .failure(let error):
                self.alertMessage = error.localizedDescription
                self.updateFeed()
            }
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
