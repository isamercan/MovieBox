//
//  Router.swift
//  TheMovieBox
//
//  Created by isa Mercan on 21.12.2022.
//

import Foundation
import Alamofire

enum Router: URLRequestConvertible {
    
    static let baseUrl = NetworkConstants.baseUrl
    case genres
    case popularMovies
    case highlyRatedMovies
    case upcomingMovies
    case movieDetail(id: String)
    case movieReviews(id: String)
    case similarMovies(id: String)
    
    var method: HTTPMethod {
        switch self {
        case .genres, .movieDetail, .popularMovies, .highlyRatedMovies, .movieReviews, .similarMovies, .upcomingMovies:
            return .get
        }
    }
    
    var path: String {
        switch self {
        case .popularMovies:
            return "/movie/popular"
        case .movieDetail(let movieId):
            return "/movie/\(movieId)"
        case .movieReviews(let movieId):
            return "/movie/\(movieId)/reviews"
        case .similarMovies(let movieId):
            return "/movie/\(movieId)/similar"
        case .upcomingMovies:
            return "/movie/upcoming"
        case .highlyRatedMovies:
            return "/movie/top_rated"
        default:
            return ""
        }
    }
        
    
    var parameters: [String: Any] {
        switch self {
        default:
            return [NetworkParameterKeys.language.rawValue : NetworkConstants.language,
                    NetworkParameterKeys.apiKey.rawValue : NetworkConstants.apiKey]
        }
    }
    
    public func asURLRequest() throws -> URLRequest {
        let url = try Router.baseUrl.asURL()
        var request = URLRequest(url: url.appendingPathComponent(path))
        request.httpMethod = method.rawValue
        request.timeoutInterval = 20
        return try URLEncoding.default.encode(request, with: parameters)
    }
    
    enum NetworkParameterKeys: String {
        case language = "language"
        case apiKey = "api_key"
        case pageIndex = "page"
    }
}
