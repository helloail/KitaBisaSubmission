//
//  File.swift
//  KitaBisaSubmissionTests
//
//  Created by Moh Zinnur Atthufail Addausi on 12/03/21.
//

import Foundation
import XCTest
@testable import KitaBisaSubmission

class ReviewViewModelTest: XCTestCase {

    func test_TopListViewModel_whenProvideData_thenCountOneItem() {
        
        // given
        let expectedData = ReviewsModel.load()
        let service = MockReviewRemoteDataSource(mockData: expectedData)
        let viewModel = ReviewViewModel(reviewservice: service)
        
        // when
        
        service.catchdataStatus = .success(expectedData)
        viewModel.fetchArticleExecute(key: 1)
        
        // then
        XCTAssertEqual(viewModel.list.value?.count, 1)
    }

    func test_TopListViewModel_whenProvideEmptyData_thenZeroItem() {

        // given
        let expectedData = ReviewsModel(id: 1, results: [])
        let service = MockReviewRemoteDataSource(mockData: expectedData)
        let viewModel = ReviewViewModel(reviewservice: service)

        // when
        service.catchdataStatus = .success(expectedData)
        viewModel.fetchArticleExecute(key: 1)

        // then
        XCTAssertEqual(viewModel.list.value?.count, 0)
    }

    func test_TopListViewModel_whenPovideNilData_ThenZeroItem() {
        
        // given
        let expectedData: ReviewsModel? = nil
        guard let expecteddata = expectedData else {
            return
        }
        let service = MockReviewRemoteDataSource(mockData: expecteddata)
        let viewModel = ReviewViewModel(reviewservice: service)
        
        // when
        service.catchdataStatus = .success(expecteddata)
        viewModel.fetchArticleExecute(key: 1)
        
        // then
        XCTAssertEqual(viewModel.list.value?.count, 0)
    }
    
    func test_TopListViewModel_whenProvideErrorResponse_thenError() {
        
        // given
        let expectedData = ReviewsModel.load()
        let service = MockReviewRemoteDataSource(mockData: expectedData)
        service.catchdataStatus = .failure(NSError(domain: "", code: -1, userInfo: nil))
        let viewModel = ReviewViewModel(reviewservice: service)
        
        // when
        viewModel.fetchArticleExecute(key: 1)
        
        // then
        XCTAssertNotNil(viewModel.errorMessage)
    }
}
