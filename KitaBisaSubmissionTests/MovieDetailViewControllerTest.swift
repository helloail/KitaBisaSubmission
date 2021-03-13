//
//  MovieDetailViewController.swift
//  KitaBisaSubmissionTests
//
//  Created by Moh Zinnur Atthufail Addausi on 13/03/21.
//

import Foundation
import XCTest
@testable import KitaBisaSubmission

class MovieDetailViewControllerTest: XCTestCase {
    func test_viewDidLoad_outletsShouldNotNil() {
        let sut = makeSUT()
        
        sut.loadView()
        sut.viewDidLoad()
        
        XCTAssertNotNil(sut.titleMovieDetailViewController)
        XCTAssertNotNil(sut.releasedateMovieDetailViewController)
        XCTAssertNotNil(sut.overviewMovieDetailViewController)
        XCTAssertNotNil(sut.releasedateMovieDetailViewController)
        XCTAssertNotNil(sut.imageMovieDetailViewController)
        XCTAssertNotNil(sut.TVReviewMovie)
        XCTAssertNotNil(sut.favouriteButtonDetailViewController)
    }
    
    private func makeSUT() -> MovieDetailViewController {
        let storyboard = UIStoryboard(name: "MovieDetails", bundle: .main)
        return storyboard.instantiateViewController(identifier: MovieDetailViewController.idMovieDetail) as! MovieDetailViewController
    }
    
}
