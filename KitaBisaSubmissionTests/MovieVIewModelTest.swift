//
//  MovieVIewModelTest.swift
//  KitaBisaSubmissionTests
//
//  Created by Moh Zinnur Atthufail Addausi on 12/03/21.
//

import Foundation
import XCTest
@testable import KitaBisaSubmission

class MovieViewModelTest: XCTestCase {

    func test_TopListViewModel_whenProvideData_thenCountOneItem() {
        
        // given
        let expectedData = MoviedModel.load()
        let service = MockMovieRemoteDataSource(mockData: expectedData)
        let viewModel = MovieViewModel(movieservice: service)
        
        // when
        
        service.catchdataStatus = .success(expectedData)
        viewModel.didload("")
        
        // then
        XCTAssertEqual(viewModel.list.value?.count, 1)
    }

    func test_TopListViewModel_whenProvideEmptyData_thenZeroItem() {

        // given
        let expectedData = MoviedModel(page: 1, results: [])
        let service = MockMovieRemoteDataSource(mockData: expectedData)
        let viewModel = MovieViewModel(movieservice: service)

        // when
        service.catchdataStatus = .success(expectedData)
        viewModel.didload("")

        // then
        XCTAssertEqual(viewModel.list.value?.count, 0)
    }

    func test_TopListViewModel_whenPovideNilData_ThenZeroItem() {
        
        // given
        let expectedData: MoviedModel? = nil
        guard let expecteddata = expectedData else {
            return
        }
        let service = MockMovieRemoteDataSource(mockData: expecteddata)
        let viewModel = MovieViewModel(movieservice: service)
        
        // when
        service.catchdataStatus = .success(expecteddata)
        viewModel.didload("")
        
        // then
        XCTAssertEqual(viewModel.list.value?.count, 0)
    }
    
    func test_TopListViewModel_whenProvideErrorResponse_thenError() {
        
        // given
        let expectedData = MoviedModel.load()
        let service = MockMovieRemoteDataSource(mockData: expectedData)
        service.catchdataStatus = .failure(NSError(domain: "", code: -1, userInfo: nil))
        let viewModel = MovieViewModel(movieservice: service)
        
        // when
        viewModel.didload("")
        
        // then
        XCTAssertNotNil(viewModel.errorMessage)
    }
}
