//
//  Book.swift
//  Week3_GoogleBook
//
//  Created by Sky on 9/16/19.
//  Copyright © 2019 Sky. All rights reserved.
//

import Foundation
import UIKit
/*
BookResponse
-> [Book] - "items"
    -> VolumeInfo
        -> authors[] -> turn into String author
        -> desciption -> desc
        -> ImageLinks:
                ->smallThumbnail -> image
                ->thumbnail -> bigImage
        -> title
 */

struct BookResponse: Decodable {
    // let books: [Book]
    let books: [FavBook]
    let totalItems: Int
    let kind: String
    private enum CodingKeys: String, CodingKey {
        case books = "items"
        case totalItems, kind
    }
    
}

class Book: Decodable {
    let volumeInfo: VolumeInfo
    
    func getImage(completion: @escaping (UIImage?) -> Void) {
        guard let url = URL(string: volumeInfo.imageLinks.smallThumbnail) else {
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
    
    func getBigImage(completion: @escaping (UIImage?) -> Void) {
        guard let url = URL(string: volumeInfo.imageLinks.thumbnail) else {
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

struct VolumeInfo: Codable {
    let title: String
    let authors: [String]
    let imageLinks: ImageLinks
    let publisher: String
    let publishedDate: String
    let description: String
    let pageCount: Int 
}

struct ImageLinks: Codable {
    let smallThumbnail: String
    let thumbnail: String
}


