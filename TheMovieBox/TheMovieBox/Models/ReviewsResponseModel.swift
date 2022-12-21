//
//  ReviewsResponseModel.swift
//  TheMovieBox
//
//  Created by isa Mercan on 21.12.2022.
//


import Foundation

// MARK: - ReviewsResponseModel
struct ReviewsResponseModel: Codable {
    let id, page: Int?
    let results: [Review]?
    let totalPages, totalResults: Int?

    enum CodingKeys: String, CodingKey {
        case id, page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}
