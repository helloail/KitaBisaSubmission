//
//  Response.swift
//  KitaBisaSubmission
//
//  Created by Moh Zinnur Atthufail Addausi on 10/03/21.
//

import Foundation

struct ReviewsModel: Codable {
 
    var id: Int?
    var results: [ReviewsResult]?
}

// MARK: - Result
struct ReviewsResult: Codable {
    var author: String?
    var authorDetails: AuthorDetails?
    var content: String?
    var createdAt: String?
    var id: String?
    var updatedAt: String?
    var url: String?

    enum CodingKeys: String, CodingKey {
        case author = "author"
        case authorDetails = "author_details"
        case content = "content"
        case createdAt = "created_at"
        case id = "id"
        case updatedAt = "updated_at"
        case url = "url"
    }
}

// MARK: - AuthorDetails
struct AuthorDetails: Codable {
    let name: String?
    let username: String?
    let avatarPath: String?
    let rating: Int?

    enum CodingKeys: String, CodingKey {
        case name = "name"
        case username = "username"
        case avatarPath = "avatar_path"
        case rating = "rating"
    }
}
