//
//  FavBook+CoreDataClass.swift
//  Week3_GoogleBook
//
//  Created by Sky on 9/20/19.
//  Copyright © 2019 Sky. All rights reserved.
//
//

import Foundation
import CoreData

extension CodingUserInfoKey {
    static let context: CodingUserInfoKey = CodingUserInfoKey.init(rawValue: "NSManagedObjectContext")!
}

struct FavBookErrors: Error {
    let errorMessage: String
}

@objc(FavBook)
public class FavBook: NSManagedObject, Decodable {
    
    enum BookCodingKeys: String, CodingKey {
        case volumeInfo
        case title
        case authors
        case imageLinks
        case bigImage = "thumbnail"
        case image = "smallThumbnail"
        case desc = "description"
    }
    
    public required init(from decoder: Decoder) throws {
        guard let context = decoder.userInfo[.context] as? NSManagedObjectContext else {
            throw FavBookErrors(errorMessage: "Context not found")
        }
        let entityDesc = NSEntityDescription.entity(forEntityName: "FavBook", in: context)!
        super.init(entity: entityDesc, insertInto: context)
        
        let container = try decoder.container(keyedBy: BookCodingKeys.self)
        
        let volumeInfo = try container.nestedContainer(keyedBy: BookCodingKeys.self,
                                                   forKey: .volumeInfo)
        
        title = try volumeInfo.decodeIfPresent(String.self, forKey: .title)
        author = try? volumeInfo.decodeIfPresent([String].self, forKey: .authors)?
            .joined(separator: " ")
        desc = try volumeInfo.decodeIfPresent(String.self, forKey: .desc)
        
        if let imageLinks = try? volumeInfo.nestedContainer(keyedBy: BookCodingKeys.self,
                                                           forKey: .imageLinks) {
            image = try imageLinks.decode(String.self, forKey: .image)
            bigImage = try imageLinks.decode(String.self, forKey: .bigImage)
        }
    }
}

// let volumeInfo: VolumeInfo
    /*
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
    */

/*
extension Array where Element == FavBook {
    
}*/
