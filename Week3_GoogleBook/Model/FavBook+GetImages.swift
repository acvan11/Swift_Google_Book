//
//  FavBook+GetImages.swift
//  Week3_GoogleBook
//
//  Created by Sky on 9/20/19.
//  Copyright © 2019 Sky. All rights reserved.
//

import UIKit

extension FavBook {
    func getImage(completion: @escaping (UIImage?) -> Void) {
        guard let imageURL = image else {
            completion(nil)
            return
        }
        getImageHelper(imageURL, completion: completion)
    }
    
    func getBigImage(completion: @escaping (UIImage?) -> Void) {
        guard let imageURL = bigImage else {
            completion(nil)
            return
        }
        getImageHelper(imageURL, completion: completion)
    }
    
    private func getImageHelper(_ imageURL: String,
                                completion: @escaping (UIImage?) -> Void) {
        guard let url = URL(string: imageURL) else {
            completion(nil)
            return
        }
        
        URLSession.shared.dataTask(with: url ) { (dat, _, _) in
            if let data = dat {
                DispatchQueue.main.async {
                    completion(UIImage(data: data))
                }
            }
            }.resume()
    }
}
