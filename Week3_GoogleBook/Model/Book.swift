//
//  Book.swift
//  Week3_GoogleBook
//
//  Created by Sky on 9/16/19.
//  Copyright © 2019 Sky. All rights reserved.
//

import Foundation
import UIKit

struct BookResponse: Decodable {
    let books: [Book]
    let totalItems: Int
    let kind: String
    private enum CodingKeys: String, CodingKey {
        case books = "items"
        case totalItems, kind
    }
    
}

class Book: Decodable {
    let volumeInfo: VolumeInfo
}

struct VolumeInfo: Codable {
    let title: String
    let subtitle: String?
    let authors: [String]
}


