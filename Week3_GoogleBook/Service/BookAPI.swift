//
//  BookAPI.swift
//  Week3_GoogleBook
//
//  Created by Sky on 9/16/19.
//  Copyright © 2019 Sky. All rights reserved.
//

import Foundation

struct BookAPI {
    //https://www.googleapis.com/books/v1/volumes?q=searchterm
    var search: String!
    
    init(search: String) {
        self.search = search
    }
    
    let base = "https://www.googleapis.com/books/v1/volumes?q="
    var getUrl: URL? {
        return URL(string: base + search)
    }
}
