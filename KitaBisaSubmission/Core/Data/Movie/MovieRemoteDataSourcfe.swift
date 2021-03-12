//
//  MovieRemoteDataSourcfe.swift
//  KitaBisaSubmission
//
//  Created by Moh Zinnur Atthufail Addausi on 10/03/21.
//

import Foundation

protocol MovieRemoteDataSourceProtocol {
    func catchMoviesList(key: String, completion: @escaping ((Swift.Result<MoviedModel, Error>) -> Void))
}

class MovieRemoteDataSource: MovieRemoteDataSourceProtocol {
    
    func catchMoviesList(key: String, completion: @escaping ((Swift.Result<MoviedModel, Error>) -> Void)) {
        
        let urlString = Endpoints.Gets.movie(key: key).url
        
        guard let encoded = urlString.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed) else {
            return
        }
        
        guard  let url = URL(string: encoded) else {
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "Get"
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("application/json", forHTTPHeaderField: "Content-type")
        
        URLSession.shared.dataTask(with: request) { (data, _, error)  in
            
            if let error = error {
                print(error)
                return
            }
            guard let data = data else { return }
            
            do {
                let posts = try JSON().newJSONDecoder().decode(MoviedModel.self, from: data)
                completion(.success(posts))
            } catch let error {
                
                print(error)
                
            }
            return
            
        }.resume()
        
    }
    
}
