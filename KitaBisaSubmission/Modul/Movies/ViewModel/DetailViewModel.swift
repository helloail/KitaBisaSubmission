//
//  DetailViewModel.swift
//  KitaBisaSubmission
//
//  Created by Moh Zinnur Atthufail Addausi on 11/03/21.
//

import Foundation

protocol DetailViewModelsinput {
    func didload(_ result: Result)
    func updateStatus(_ result: Result)
}

protocol DetailViewModelsoutput {
    var getstatus: Observable<Bool> { get set }
}

protocol DetailViewModelProtocol: DetailViewModelsoutput, DetailViewModelsinput { }

class DetailViewModel: DetailViewModelProtocol {
    
    var getstatus: Observable<Bool> = Observable(false)
    private var movieservice: CoreDataManagerProtocol
    
     init(movieservice: CoreDataManagerProtocol) {
        
        self.movieservice  = movieservice
    }
    
    func didload(_ result: Result) {
        fetchData(result: result)
    }
    
    func updateStatus(_ result: Result) {
        self.movieservice.updateData(result: result)
    }
    
    func fetchData(result: Result) {
        
        self.movieservice.fetchPartData(result: result) {[weak self] bool in
            
            if bool {
                self?.getstatus.value = true
            } else {
                self?.getstatus.value = false
            }
        }
    }
}
