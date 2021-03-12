//
//  MockMovieRemoteDataSource.swift
//  KitaBisaSubmissionTests
//
//  Created by Moh Zinnur Atthufail Addausi on 11/03/21.
//

import XCTest
@testable import KitaBisaSubmission
class MockMovieRemoteDataSource: MovieRemoteDataSourceProtocol {
 
    let mockData: MoviedModel?
    
    var catchdataStatus: Swift.Result<MoviedModel, Error>
    
    init(mockData: MoviedModel) {
        self.mockData = mockData
        self.catchdataStatus = .success(mockData)
    }
    
    func catchMoviesList(key: String, completion: @escaping ((Swift.Result<MoviedModel, Error>) -> Void)) {
        
        completion(catchdataStatus)
    }

}
