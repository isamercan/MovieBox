//
//  DashboardVM.swift
//  TheMovieBox
//
//  Created by isa Mercan on 21.12.2022.
//

import UIKit
enum DashboardCellType {
    case empty
    case header
    case popularMovies(items: [MovieModel])
    case highlyRatedMovies(items: [MovieModel])
    case upcomingMovies(items: [MovieModel])
    case favoriteMovies(items: [MovieModel])
    
    static func ==(lhs: DashboardCellType, rhs: DashboardCellType) -> Bool {
        switch (lhs, rhs) {
        case (.favoriteMovies(_), .favoriteMovies(_)):
            return true
        default:
            return false
        }
    }
    
    public var title : String {
        switch self {
        case .empty:
            return "Empty"
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
        self.cellTypes = []
        self.cellTypes.append(.header)
        api.getMostPopularMovies { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let movies):
                if let movies = movies?.results {
                    self.cellTypes.append(.popularMovies(items: movies))
                    self.getHighlyRatedMovies()
                }
            case .failure(let error):
                self.alertMessage = error.localizedDescription
                self.getHighlyRatedMovies()
            }
        }
    }
    
    func getHighlyRatedMovies() {
        api.getHighlyRatedMovies { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let movies):
                if let movies = movies?.results, movies.count > 0 {
                    self.cellTypes.append(.highlyRatedMovies(items: movies))
                    self.getUpcomingMovies()
                }
            case .failure(let error):
                self.alertMessage = error.localizedDescription
                self.getUpcomingMovies()
            }
        }
    }
    
    func getUpcomingMovies() {
        api.getUpcomingMovies { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let movies):
                if let movies = movies?.results, movies.count > 0 {
                    self.cellTypes.append(.upcomingMovies(items: movies))
                    self.getFavoriteMovies()
                }
            case .failure(let error):
                self.alertMessage = error.localizedDescription
                if self.cellTypes.count == 1 { self.cellTypes.append(.empty) }
                self.getFavoriteMovies()
            }
        }
    }
    
    func getFavoriteMovies() {
        let movies = UserDefaultsManager.shared.getStoredMovies(forKey: .FavoriteMovies)
        guard movies.count > 0 else {
            self.updateFeed()
            return
        }
        self.cellTypes.removeAll(where: { $0 == .favoriteMovies(items: movies) })
        self.cellTypes.append(.favoriteMovies(items: movies))
        self.updateFeed()
    }
}
