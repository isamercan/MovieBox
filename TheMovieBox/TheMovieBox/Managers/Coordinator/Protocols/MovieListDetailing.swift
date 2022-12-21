//
//  MovieListDetailing.swift
//  TheMovieBox
//
//  Created by isa Mercan on 21.12.2022.
//
import UIKit

protocol MovieListDetailing: AnyObject {
    var reloadAll: (() -> ())? { get set }
    func fetchMovieList()
    func numberOfItem() -> Int
    func cellSize() -> CGSize
    func cellVM() -> String
}
