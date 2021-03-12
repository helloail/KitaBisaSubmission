//
//  MovieRemoteDataTest.swift
//  KitaBisaSubmissionTests
//
//  Created by Moh Zinnur Atthufail Addausi on 12/03/21.
//

import Foundation
import XCTest

@testable import KitaBisaSubmission

class MovieRemoteDataTest: XCTestCase {
    
    func test_ParserData_whenJsonData_thenSuccessParser() {
        // given
        let json = """
        {
            "dates": {
                "maximum": "2021-03-16",
                "minimum": "2021-01-27"
            },
            "page": 1,
            "results": [
                {
                    "adult": false,
                    "backdrop_path": "/rcUcYzGGicDvhDs58uM44tJKB9F.jpg",
                    "genre_ids": [
                        16,
                        12,
                        14,
                        10751,
                        28,
                        18
                    ],
                    "id": 527774,
                    "original_language": "en",
                    "original_title": "Raya and the Last Dragon",
                    "overview": "Long ago, in the fantasy world of Kumandra, humans and dragons lived together in harmony.",
                    "popularity": 4783.538,
                    "poster_path": "/lPsD10PP4rgUGiGR4CCXA6iY0QQ.jpg",
                    "release_date": "2021-03-03",
                    "title": "Raya and the Last Dragon",
                    "video": false,
                    "vote_average": 8.6,
                    "vote_count": 823
                }
            ],
            "total_pages": 40,
            "total_results": 798
        }
        """.data(using: .utf8)!
        
        // when
        let posts = try? JSON().newJSONDecoder().decode(MoviedModel.self, from: json)
        
        // then
        XCTAssertNotNil(posts)
        XCTAssertEqual(posts?.results?.first?.id, MoviedModel.load().results?.first?.id)
        
    }
}
