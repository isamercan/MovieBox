//
//  MoviesResponseModel.swift
//  TheMovieBox
//
//  Created by isa Mercan on 21.12.2022.
//

import Foundation

struct MoviesResponseModel: Codable {
  let page: Int
  let results: [MovieModel]
  let totalPages, totalResults: Int
  
  enum CodingKeys: String, CodingKey {
    case page, results
    case totalPages = "total_pages"
    case totalResults = "total_results"
  }
}
