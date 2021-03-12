//
//  CoreDataManager.swift
//  KitaBisaSubmission
//
//  Created by Moh Zinnur Atthufail Addausi on 11/03/21.
//

import Foundation
import CoreData

protocol CoreDataManagerProtocol {
    func fetchPartData(result: Result, complition: @escaping (Bool) -> Void)
    func updateData(result: Result)
    func fetchMovies(completion: @escaping ((Swift.Result<[Movie], Error>) -> Void))
}

class CoreDataManager: CoreDataManagerProtocol {
   
    lazy var persistentconteiner: NSPersistentContainer = {
        let persistentconteiner  = NSPersistentContainer(name: "KitaBisaSubmission")
        persistentconteiner.loadPersistentStores { _, _ in
            
        }
        return persistentconteiner
    }()
    
    var moc: NSManagedObjectContext {
        persistentconteiner.viewContext
    }
    
    func fetchPartData(result: Result, complition: @escaping (Bool) -> Void) {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Movie")
        let predicate = NSPredicate(format: "title == %@", result.title!)
        
        request.predicate = predicate
        
        do {
            let results = try moc.fetch(request)
            if results.count > 0 {
                complition(true)
            } else {
                complition(false)
            }
        } catch {
            fatalError("Failed to fetch employees: \(error)")
        }
    }
    
    func updateData(result: Result) {
        
        fetchPartData(result: result) { [weak self] bool in
            if bool {
                self?.deleteMovie(title: result.title!)
            } else {
                self?.saveDataMovie(result: result)
            }
        }
    }
    
    func fetchMovies( completion: @escaping ((Swift.Result<[Movie], Error>) -> Void)) {
        do {
            let request = NSFetchRequest<Movie>(entityName: "Movie")
            let results = try moc.fetch(request)
            completion(.success(results))
        } catch {
            completion(.failure(error))
        }
    }
    
   private func saveDataMovie(result: Result) {
      
        let movie = Movie(context: self.moc)
        
        movie.setValue(result.id, forKeyPath: "id")
        
        movie.setValue(result.overview, forKeyPath: "overview")
        
        movie.setValue(result.releaseDate, forKeyPath: "releasedate")
        
        movie.setValue(result.title, forKeyPath: "title")
        
        movie.setValue(result.posterPath, forKeyPath: "posterpath")
        
        do {
            try self.moc.save()
            
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    private func deleteMovie(title: String) {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Movie")
        let predicate = NSPredicate(format: "title == %@", title)
        request.predicate = predicate
        
        do {
            let test = try moc.fetch(request)
            let objectdelete = (test[0] as? NSManagedObject)!
            moc.delete(objectdelete)
            do {
                try moc.save()
                
            } catch let error as NSError {
                print("Could not save. \(error), \(error.userInfo)")
                
            }
        } catch {
            print(error)
        }
    }
}
