//
//  File.swift
//  KitaBisaSubmission
//
//  Created by Moh Zinnur Atthufail Addausi on 10/03/21.
//

import Foundation

enum MovieViewModelsRoute {
    case initial
    case favorite
    case detailmovies(_ movie: Result)
    
}

protocol MovieViewModelsinput {
    func didload(_ key: String)
}

protocol MovieViewModelsoutput {
    var list: Observable<[Result]?> { get }
    var loading: Observable<Bool> { get set }
    var errorMessage: Observable<String?> { get set }
    var route: Observable<MovieViewModelsRoute> { get set }
}

protocol MovieViewModelProtocol: MovieViewModelsinput, MovieViewModelsoutput { }

class MovieViewModel: MovieViewModelProtocol {
    func didload(_ key: String) {
        fetchData(key: key)
    }
    
    private var movieservice: MovieRemoteDataSourceProtocol
    
     init(movieservice: MovieRemoteDataSourceProtocol) {
        
        self.movieservice  = movieservice
    }
    
    func fetchData(key: String) {
        loading.value = true

        self.movieservice.catchMoviesList(key: key) { [weak self] result in

            switch result {

            case .success(let result) :
                self?.list.value = result.results

            case .failure(let error):

                self?.errorMessage.value = error.localizedDescription

            }
            self?.loading.value = false
        }
    }
    var list: Observable<[Result]?> = Observable([Result()])
    
    var loading: Observable<Bool> = Observable(false)
    
    var errorMessage: Observable<String?> = Observable(nil)
    
    var route: Observable<MovieViewModelsRoute> = Observable(.initial)
}
