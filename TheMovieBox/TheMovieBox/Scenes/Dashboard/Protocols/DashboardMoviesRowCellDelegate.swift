//
//  DashboardMoviesRowCellDelegate.swift
//  TheMovieBox
//
//  Created by isa Mercan on 21.12.2022.
//

import Foundation

protocol DashboardMoviesRowCellDelegate: AnyObject {
    func didTappedMovieItem(model: MovieModel)
}
