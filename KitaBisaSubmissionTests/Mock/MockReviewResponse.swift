//
//  MockReviewResponse.swift
//  KitaBisaSubmissionTests
//
//  Created by Moh Zinnur Atthufail Addausi on 11/03/21.
//

import Foundation
import XCTest

@testable import KitaBisaSubmission

extension ReviewsModel {
    static func load() -> ReviewsModel {
        return ReviewsModel(id: 1,
                            results:
                                [ReviewsResult(
                                    author: "Louisa Moore - Screen Zealots",
                                    authorDetails:
                                        AuthorDetails(
                                            name: "Louisa Moore - Screen Zealots",
                                            username: "screenzealots",
                                            avatarPath: "/https://secure.gravatar.com/avatar/70d4177132896d293b72f4c595521141.jpg",
                                            rating: 4),
                                    content: "One of the best things I can say about the “Tom and Jerry” feature movie, now streaming on HBO Max",
                                    createdAt: "2021-03-09T15:42:27.392Z",
                                    id: "60479763c4ad590044e8dc85",
                                    updatedAt: "2021-03-09T15:42:27.392Z",
                                    url: "https://www.themoviedb.org/review/60479763c4ad590044e8dc85")])
    }
    
}
