//
//  FavoriteListViewModel.swift
//  KitaBisaSubmission
//
//  Created by Moh Zinnur Atthufail Addausi on 11/03/21.
//

import Foundation

enum FavoriteViewModelsRoute {
    case initial
    case detailfavourites(_ movie: Movie)
    
}

protocol FavoriteViewModelsinput {
    func didload()
}

protocol FavoriteViewModelsoutput {
    var list: Observable<[Movie]?> { get }
    var loading: Observable<Bool> { get set }
    var errorMessage: Observable<String?> { get set }
    var route: Observable<FavoriteViewModelsRoute> { get set }
}

protocol FavoriteViewModelProtocol: FavoriteViewModelsinput, FavoriteViewModelsoutput { }

class FavoriteViewModel: FavoriteViewModelProtocol {
    
    var list: Observable<[Movie]?> = Observable([Movie()])
    var loading: Observable<Bool> = Observable(false)
    var errorMessage: Observable<String?> = Observable(nil)
    var route: Observable<FavoriteViewModelsRoute> = Observable(.initial)
    private var movieservice: CoreDataManagerProtocol
    
     init(movieservice: CoreDataManagerProtocol) {
        
        self.movieservice = movieservice
    }
   
    func didload() {
        fetchData()
    }
    
    func fetchData() {
        loading.value = true
        
        self.movieservice.fetchMovies { [weak self] result in
            
            switch result {
            
            case .success(let result) :
                self?.list.value = result
                
            case .failure(let error):
                self?.errorMessage.value = error.localizedDescription
                
            }
            self?.loading.value = false
        }
    }
    
}
