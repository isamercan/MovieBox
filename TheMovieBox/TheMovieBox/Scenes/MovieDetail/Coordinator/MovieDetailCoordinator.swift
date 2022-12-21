//
//  MovieDetailCoordinator.swift
//  TheMovieBox
//
//  Created by isa Mercan on 21.12.2022.
//

import Foundation

class MovieDetailCoordinator: BaseCoordinator {
    func goMovieDetail(movie: MovieModel) {
        let vc = MovieDetailVC.instantiate(from: .movie)
        let detailVM = MovieDetailVM(movieId: movie.id ?? 0)
        vc.viewModel = detailVM
        vc.coordinator = self
        push(vc)
    }
    
    func goHome() {
        start()
    }
}
