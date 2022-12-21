//
//  UserDefaultsManager.swift
//  TheMovieBox
//
//  Created by isa Mercan on 21.12.2022.
//

import UIKit
import Default

class UserDefaultsManager {
    static let shared = UserDefaultsManager()
    private init() { }
    
    func addMovie(model: MovieModel, forKey: DefaultStorageConstants.Keys) {
        guard !isInList(model: model, forKey: forKey) else { return }
        var list = getStoredMovies(forKey: forKey)
        list.append(model)
        UserDefaults.standard.df.store(list, forKey: forKey.rawValue)
    }
    
    func removeMovie(model: MovieModel, forKey: DefaultStorageConstants.Keys) {
        guard let movieId = model.id, isInList(model: model, forKey: forKey) else { return }
        var list = getStoredMovies(forKey: forKey)
        list.removeAll { $0.id == movieId }
        UserDefaults.standard.df.store(list, forKey: forKey.rawValue)
    }
    
    func getStoredMovies(forKey: DefaultStorageConstants.Keys) -> [MovieModel] {
        return UserDefaults.standard.df.fetch(forKey: forKey.rawValue, type: [MovieModel].self) ?? []
    }
    
    func isInList(model: MovieModel, forKey: DefaultStorageConstants.Keys) -> Bool {
        let list = getStoredMovies(forKey: forKey)
        guard let movieId = model.id, list.count > 0 else { return false }
        return list.contains(where: { $0.id == movieId })
    }
}

