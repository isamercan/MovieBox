//
//  Client.swift
//  TheMovieBox
//
//  Created by isa Mercan on 21.12.2022.
//

import Foundation
import Alamofire

protocol ClientProtocol {
    func makeRequestWithData<T: Codable>(route: URLRequestConvertible, response: T.Type, completion: @escaping (_ responseData: T?, _ error: Error?) -> Void)
}

class Client: ClientProtocol {
   
    func makeRequestWithData<T: Codable>(route: URLRequestConvertible, response: T.Type, completion: @escaping (_ responseData: T?, _ error: Error?) -> Void) {
        AF.request(route).validate().responseData { (response) in
            switch response.result {
            case .success(let data):
                let result = self.convertToModel(data: data, decodingType: T.self)
                completion(result, nil)
            case .failure(let error):
                completion(nil, error)
            }
        }
    }
    
    func convertToModel<T: Codable>(data: Data, decodingType: T.Type) -> T? {
        do {
            return try JSONDecoder().decode(T.self, from: data)
        } catch {
            return nil
        }
    }
}
