//
//  ReviewRemoteDataSource.swift
//  KitaBisaSubmission
//
//  Created by Moh Zinnur Atthufail Addausi on 10/03/21.
//

import Foundation
protocol ReviewsRemoteDataSourceProtocol {
    func catchReviewList(key: Int, completion: @escaping ((Swift.Result<ReviewsModel, Error>) -> Void))
}

class ReviewsRemoteDataSource: ReviewsRemoteDataSourceProtocol {
    
    func catchReviewList(key: Int, completion: @escaping ((Swift.Result<ReviewsModel, Error>) -> Void)) {
        
        let urlString = Endpoints.Gets.reviews(key: key).url
        
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
                let posts = try JSON().newJSONDecoder().decode(ReviewsModel.self, from: data)
        
                completion(.success(posts))
            } catch let error {
                
                print(error)
                
            }
            return
            
        }.resume()
        
    }
    
}
