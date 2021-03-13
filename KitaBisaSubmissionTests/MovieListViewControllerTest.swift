//
//  MovieListViewControllerTest.swift
//  KitaBisaSubmissionTests
//
//  Created by Moh Zinnur Atthufail Addausi on 13/03/21.
//

import Foundation
import XCTest
@testable import KitaBisaSubmission

class MovieListViewControllerTest: XCTestCase {
    func test_viewDidLoad_outletsShouldNotNil() {
        let sut = makeSUT()
        
        sut.loadView()
        sut.viewDidLoad()
        
        XCTAssertNotNil(sut.TVListMovie)
        XCTAssertNotNil(sut.RigtBarButtonFavorite)
        XCTAssertNotNil(sut.ButtonMovieSelection)
    }
    
    private func makeSUT() -> MovieListViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: .main)
        return storyboard.instantiateViewController(identifier: "Main") as! MovieListViewController
    }
    
}
