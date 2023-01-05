//
//  ConnectivityManager.swift
//  TheMovieBox
//
//  Created by isa Mercan on 5.01.2023.
//

import Foundation
import Alamofire

public class ConnectivityManager {
  static let shared = NetworkReachabilityManager()!
  static var isConnectedToInternet:Bool {
      return self.shared.isReachable
    }
}
