//
//  FavoriteViewModelTest.swift
//  KitaBisaSubmissionTests
//
//  Created by Moh Zinnur Atthufail Addausi on 12/03/21.
//

import XCTest

@testable import KitaBisaSubmission

class FavoriteViewModelTest: XCTestCase {
    
    let moc = CoreDataHelper().moc
    
    func test_favoriteViewModel_whenProvideData_thenCountOneItem() {
        
        // given
        let  expectedData = Movie(context: moc)
        let service = MockMovieLocaleDataSource(mockData: [expectedData])
        let viewmodel = FavoriteViewModel(movieservice: service )
        
        // when
        viewmodel.didload()
        
        // then
        
        XCTAssertEqual(viewmodel.list.value?.count, 1)
        
    }
    
    func test_TopListViewModel_whenProvideErrorResponse_thenError() {
        
        // given
        let expectedData = Movie(context: moc)
        let service = MockMovieLocaleDataSource(mockData: [expectedData])
        service.catchdataStatus = .failure(NSError(domain: "", code: -1, userInfo: nil))
        let viewModel = FavoriteViewModel(movieservice: service )
        
        // when
        viewModel.didload()
        
        // then
        XCTAssertNotNil(viewModel.errorMessage)
    }

}
