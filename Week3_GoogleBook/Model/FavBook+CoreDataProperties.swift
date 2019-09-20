//
//  FavBook+CoreDataProperties.swift
//  Week3_GoogleBook
//
//  Created by Sky on 9/20/19.
//  Copyright © 2019 Sky. All rights reserved.
//
//

import Foundation
import CoreData


extension FavBook {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FavBook> {
        return NSFetchRequest<FavBook>(entityName: "FavBook")
    }

    @NSManaged public var title: String?
    @NSManaged public var author: String?
    @NSManaged public var image: String?
    @NSManaged public var bigImage: String?
    @NSManaged public var desc: String?

}
