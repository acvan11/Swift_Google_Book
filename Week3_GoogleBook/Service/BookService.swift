//
//  BookService.swift
//  Week3_GoogleBook
//
//  Created by Sky on 9/16/19.
//  Copyright © 2019 Sky. All rights reserved.
//

import Foundation

typealias BookHandler = ([FavBook]) -> Void

final class BookService {
    
    static let shared = BookService()
    private init() {}
    
    func getBooks(for search: String, completion: @escaping BookHandler) {
        guard let url = BookAPI(search: search).getUrl else {
            completion([])
            return
        }
        
        URLSession.shared.dataTask(with: url) { (dat, _, err) in
            if let error = err {
                print("Bad Task: \(error.localizedDescription)")
                completion([])
                return
            }
            
            if let data = dat {
                do {
                    let decoder = JSONDecoder()
                    decoder.userInfo = [.context: CoreManager.shared.context]
                    let response = try decoder.decode(/*[FavBook]*/BookResponse.self,
                                                                   from: data)
                    // let books = bookResponse.books
                    let books = response.books
                    print("Print out array of books")
                    print(books)
                    completion(books)
                } catch let myError {
                    print("Couldn't Decode Book: \(myError.localizedDescription)")
                    completion([])
                    return
                }
            }
            }.resume()
        }
  
}
