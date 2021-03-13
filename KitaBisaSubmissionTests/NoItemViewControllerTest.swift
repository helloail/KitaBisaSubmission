//
//  NoItemViewControllerTest.swift
//  KitaBisaSubmissionTests
//
//  Created by Moh Zinnur Atthufail Addausi on 12/03/21.
//

import XCTest

@testable import KitaBisaSubmission
class NoItemViewControllerTest: XCTestCase {
    
    func test_viewDidLoad_storyboardIdShouldNotNil() {
        let controller = NoItemMovieViewController()
        controller.loadView()
        controller.viewDidLoad()
        
        XCTAssertNotNil(NoItemMovieViewController.idnoitemmovie)
        XCTAssertNotNil(NoItemMovieViewController.idnoitemreview)
    }
    
    func test_viewDidLoad_storyboardShouldInInitialState() {
        
        let controller = NoItemMovieViewController()
        controller.viewDidLoad()
        
        XCTAssertEqual(NoItemMovieViewController.idnoitemmovie, "idnoitemmovie")
        XCTAssertEqual(NoItemMovieViewController.idnoitemreview, "idnoitemreview")
    }
}
