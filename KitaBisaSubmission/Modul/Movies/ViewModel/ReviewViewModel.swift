//
//  ReviewViewModel.swift
//  KitaBisaSubmission
//
//  Created by Moh Zinnur Atthufail Addausi on 10/03/21.
//

import Foundation

protocol ReviewViewModelsinput {
    func didload(_ key: Int)
}

protocol ReviewViewModelsoutput {
    var list: Observable<[ReviewsResult]?> { get }
    var loading: Observable<Bool> { get set }
    var errorMessage: Observable<String?> { get set }
}

protocol ReviewViewModelProtocol: ReviewViewModelsinput, ReviewViewModelsoutput { }

class ReviewViewModel: ReviewViewModelProtocol {
    func didload(_ key: Int) {
        fetchArticleExecute(key: key)
    }
    
    private var reviewservice: ReviewsRemoteDataSourceProtocol
    
    init(reviewservice: ReviewsRemoteDataSourceProtocol) {
        
        self.reviewservice = reviewservice
    }
    
    func fetchArticleExecute(key: Int) {
        loading.value = true
        
        self.reviewservice.catchReviewList(key: key) { [weak self] result in
            
            switch result {
            
            case .success(let result) :
                self?.list.value = result.results
                
            case .failure(let error):
                
                self?.errorMessage.value = error.localizedDescription
                
            }
            self?.loading.value = false
        }
    }
    var list: Observable<[ReviewsResult]?> = Observable([ReviewsResult()])
    
    var loading: Observable<Bool> = Observable(false)
    
    var errorMessage: Observable<String?> = Observable(nil)
    
}
