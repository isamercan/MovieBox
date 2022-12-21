//
//  DashboardCoordinator.swift
//  TheMovieBox
//
//  Created by isa Mercan on 21.12.2022.
//

import Foundation

class DashboardCoordinator: BaseCoordinator {
    func goMovieDetail(movieID: Int) {
        let vc = MovieDetailVC.instantiate(from: .movie)
        let detailVM = MovieDetailVM(movieId: movieID)        
        vc.viewModel = detailVM
        vc.coordinator = MovieDetailCoordinator(navigationController: self.navigationController)
        push(vc)
    }
}
