//
//  DashboardVM.swift
//  TheMovieBox
//
//  Created by isa Mercan on 21.12.2022.
//

import UIKit
enum DashboardCellType {
    case header
    case popularMovies(items: [MovieModel])
    case highlyRatedMovies(items: [MovieModel])
    case upcomingMovies(items: [MovieModel])
    case favoriteMovies(items: [MovieModel])
    
    public var title : String {
        switch self {
        case .header:
            return "Muvi"
        case .popularMovies:
            return "Popular Movies"
        case .highlyRatedMovies:
            return "Highly Rated Movies"
        case .upcomingMovies:
            return "Upcoming Movies"
        case .favoriteMovies:
            return "Favorite Movies"
        }
    }
}

class DashboardVM {
    var cellTypes: [DashboardCellType] = []
    
    var popularMovies: [MovieModel] = []
    var highlyRatedMovies: [MovieModel] = []
    var upcomingMovies: [MovieModel] = []
    var favoriteMovies: [MovieModel] = []
    var showAlertClosure: ((String) -> Void)?
    var reloadDataClosure: (() -> Void)?
    var alertMessage: String? {
        didSet {
            if let msg = self.alertMessage {
                self.showAlertClosure?(msg)
            }
        }
    }
    var api = DashboardAPI()
    init() {
        getPopularMovies()
    }
    
    func updateFeed() {
        reloadDataClosure?()
    }
    
    func getPopularMovies() {
        api.getMostPopularMovies { [weak self] (results, error) in
            guard let self = self, error == nil, let movies = results, movies.count > 0 else {
                self?.alertMessage = error?.localizedDescription ?? ""
                self?.getHighlyRatedMovies()
                return
            }
            self.cellTypes = []
            self.cellTypes.append(.header)
            self.cellTypes.append(.popularMovies(items: movies))
            self.getHighlyRatedMovies()
        }
    }
    
    func getHighlyRatedMovies() {
        api.getHighlyRatedMovies { [weak self] (results, error) in
            guard let self = self, error == nil, let movies = results, movies.count > 0 else {
                self?.alertMessage = error?.localizedDescription ?? ""
                self?.getUpcomingMovies()
                return
            }
            self.cellTypes.append(.highlyRatedMovies(items: movies))
            self.getUpcomingMovies()
        }
    }
    
    func getUpcomingMovies() {
        api.getUpcomingMovies { [weak self] (results, error) in
            guard let self = self, error == nil, let movies = results, movies.count > 0 else {
                self?.alertMessage = error?.localizedDescription ?? ""
                self?.getFavoriteMovies()
                return
            }
            self.cellTypes.append(.upcomingMovies(items: movies))
            self.getFavoriteMovies()
            
        }
    }
    
    func getFavoriteMovies() {
        let movies = UserDefaultsManager.shared.getStoredMovies(forKey: .FavoriteMovies)
        guard movies.count > 0 else {
            self.updateFeed()
            return
        }
        self.cellTypes.append(.favoriteMovies(items: movies))
        self.updateFeed()
    }
}
