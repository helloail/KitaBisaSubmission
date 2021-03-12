//
//  MockReviewMovieDataSOurce.swift
//  KitaBisaSubmissionTests
//
//  Created by Moh Zinnur Atthufail Addausi on 11/03/21.
//

import Foundation
import XCTest
@testable import KitaBisaSubmission
class MockReviewRemoteDataSource: ReviewsRemoteDataSourceProtocol {

    let mockData: ReviewsModel?
    
    var catchdataStatus: Swift.Result<ReviewsModel, Error>
    
    init(mockData: ReviewsModel) {
        self.mockData = mockData
        self.catchdataStatus = .success(mockData)
    }
    
    func catchReviewList(key: Int, completion: @escaping ((Swift.Result<ReviewsModel, Error>) -> Void)) {
        
        completion(catchdataStatus)
    }

}
