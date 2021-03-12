//
//  MockMovieLocaleDataSource.swift
//  KitaBisaSubmissionTests
//
//  Created by Moh Zinnur Atthufail Addausi on 12/03/21.
//

import Foundation

import XCTest
@testable import KitaBisaSubmission

class MockMovieLocaleDataSource: CoreDataManagerProtocol {
    
    let mockData: [Movie]?
    
    var catchdataStatus: Swift.Result<[Movie], Error>
    
    init(mockData: [Movie]) {
        self.mockData = mockData
        self.catchdataStatus = .success(mockData)
    }
    
    func fetchPartData(result: Result, complition: @escaping (Bool) -> Void) {
        complition(true)
    }
    
    func updateData(result: Result) {
        fetchPartData(result: result) { _ in
            
        }
    }
    
    func fetchMovies(completion: @escaping ((Swift.Result<[Movie], Error>) -> Void)) {
        completion(catchdataStatus)
    }
}
