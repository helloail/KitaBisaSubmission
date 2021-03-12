//
//  ReviewRemoteDataTest.swift
//  KitaBisaSubmissionTests
//
//  Created by Moh Zinnur Atthufail Addausi on 12/03/21.
//

import Foundation
import XCTest

@testable import KitaBisaSubmission

class ReviewRemoteDataTest: XCTestCase {
    
    func test_ParserData_whenJsonData_thenSuccessParser() {
        // given
        let json = """
        {
            "id": 587807,
            "page": 1,
            "results": [
                {
                    "author": "Louisa Moore - Screen Zealots",
                    "author_details": {
                        "name": "Louisa Moore - Screen Zealots",
                        "username": "screenzealots",
                        "avatar_path": "/https://secure.gravatar.com/avatar/70d4177132896d293b72f4c595521141.jpg",
                        "rating": 4.0
                    },
                    "content": "One of the best things I can say about the “Tom and Jerry” feature movie, now streaming on HBO Max, is that it isn’t wholly terrible.",
                    "created_at": "2021-03-09T15:42:27.392Z",
                    "id": "60479763c4ad590044e8dc85",
                    "updated_at": "2021-03-09T15:42:27.392Z",
                    "url": "https://www.themoviedb.org/review/60479763c4ad590044e8dc85"
                }
            ],
            "total_pages": 1,
            "total_results": 1
        }
        """.data(using: .utf8)!
        
        // when
        let posts = try? JSON().newJSONDecoder().decode(ReviewsModel.self, from: json)
        
        // then
        XCTAssertNotNil(posts)
        XCTAssertEqual(posts?.results?.first?.author, ReviewsModel.load().results?.first?.author)
        
    }
}
