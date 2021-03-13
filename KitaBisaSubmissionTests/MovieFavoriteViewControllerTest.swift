//
//  MovieFavoriteViewController.swift
//  KitaBisaSubmissionTests
//
//  Created by Moh Zinnur Atthufail Addausi on 13/03/21.
//

import Foundation
import XCTest
@testable import KitaBisaSubmission

class MovieFavoriteViewControllerTest: XCTestCase {
    func test_viewDidLoad_outletsShouldNotNil() {
        let sut = makeSUT()
        
        sut.loadView()
        sut.viewDidLoad()
        
        XCTAssertNotNil(sut.TvListMovieFavorite)
    }
    
    private func makeSUT() -> MovieFavoriteViewController {
        let storyboard = UIStoryboard(name: "Favorite", bundle: .main)
        return storyboard.instantiateViewController(identifier: "idFavorite") as! MovieFavoriteViewController
    }
}
