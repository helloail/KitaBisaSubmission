//
//  MockMovieResponse.swift
//  KitaBisaSubmissionTests
//
//  Created by Moh Zinnur Atthufail Addausi on 11/03/21.
//

import Foundation
import XCTest

@testable import KitaBisaSubmission

extension MoviedModel {
    static func load() -> MoviedModel {
        return MoviedModel(page: 1,
                           results:
                            [Result(id: 527774,
                                    overview: "Long ago, in the fantasy world of Kumandra, humans and dragons lived together in harmony",
                                    posterPath: "/lPsD10PP4rgUGiGR4CCXA6iY0QQ.jpg",
                                    releaseDate: "2021-03-03",
                                    title: "Raya and the Last Dragon")])
        
    }
    
}
