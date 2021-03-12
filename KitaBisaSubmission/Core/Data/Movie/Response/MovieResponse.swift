//
//  MovieResponse.swift
//  KitaBisaSubmission
//
//  Created by Moh Zinnur Atthufail Addausi on 10/03/21.
//

import Foundation
struct MoviedModel: Codable {
    var page: Int?
    var results: [Result]?
}

// MARK: - Result
struct Result: Codable {
    var id: Int?
    var overview: String?
    var posterPath: String?
    var releaseDate: String?
    var title: String?

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case overview = "overview"
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case title = "title"
    }
}
