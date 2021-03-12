//
//  UIImageView+LoadImage.swift
//  KitaBisaSubmission
//
//  Created by Moh Zinnur Atthufail Addausi on 10/03/21.
//

import Foundation
import UIKit
extension UIImageView {
public func LoadImage(urlString: String) {
    self.image = nil
    let urlStringNew =  urlString.replacingOccurrences(of: " ", with: "+")
    URLSession.shared.dataTask(with: NSURL(string: urlStringNew)! as URL, completionHandler: { (data, _, error) -> Void in

        if error != nil {
            print(error as Any)
            return
        }
        DispatchQueue.main.async(execute: { () -> Void in
            let image = UIImage(data: data!)
            self.image = image
        })

    }).resume()
}}
