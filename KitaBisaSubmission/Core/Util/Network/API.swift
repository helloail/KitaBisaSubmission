//
//  File.swift
//  KitaBisaSubmission
//
//  Created by Moh Zinnur Atthufail Addausi on 10/03/21.
//

import Foundation
struct API {
    static let baseUrl = "https://api.themoviedb.org/3/movie/"
    static let apikey = "507636b08f78cb257ef0da7f56dc514e"
}
protocol Endpoint {
  var url: String { get }
}

enum Endpoints {
  
  enum Gets: Endpoint {
    case movie(key: String)
    case reviews(key: Int)
    
    public var url: String {
      switch self {
      case .movie(let key): return "\(API.baseUrl)\(key)?api_key=\(API.apikey)"
      case .reviews(let key): return "\(API.baseUrl)\(key)/reviews?api_key=\(API.apikey)"
      }
    }
  }
}
