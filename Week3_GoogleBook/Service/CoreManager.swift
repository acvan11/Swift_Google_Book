//
//  CoreManager.swift
//  PersistenceTutorial827
//
//  Created by mac on 9/9/19.
//  Copyright © 2019 mac. All rights reserved.
//

import Foundation
import CoreData

let core = CoreManager.shared

final class CoreManager {
    
    
    static let shared = CoreManager()
    private init() {}
    
    
    var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    lazy var persistentContainer: NSPersistentContainer = {
        
        var container = NSPersistentContainer(name: "Week3_GoogleBook")
        
        container.loadPersistentStores(completionHandler: { (storeDescrip, err) in
            if let error = err {
                fatalError(error.localizedDescription)
            }
        })
        
        return container
    }()
    
    
    //MARK: Save
    func save(_ book: Book) {
        
        let entity = NSEntityDescription.entity(forEntityName: "FavBook", in: context)!
        let core = FavBook(entity: entity, insertInto: context)
        
        //KVC - Key Value Coding - access object property by String
        core.setValue(book.volumeInfo.title, forKey: "title")
        core.setValue(book.volumeInfo.authors[0], forKey: "author")
        core.setValue(book.volumeInfo.imageLinks.smallThumbnail, forKey: "image")
        
        print("save this book")
        saveContext()
        
    }
    
    //MARK: Delete
    func delete(_ favbook: FavBook) {
        
//        let fetchRequest = NSFetchRequest<FavBook>(entityName: "FavBook")
//        let predicate = NSPredicate(format: "id==%@", fact.id)
//        fetchRequest.predicate = predicate
//
//        var factResult = [CoreFact]()
//
//        do {
//            factResult = try context.fetch(fetchRequest)
//
//            guard let core = factResult.first else { return }
//            context.delete(core)
//            print("Deleted Fact From Core: \(fact.id)")
//
//        } catch {
//            print("Couldn't Fetch Fact: \(error.localizedDescription)")
//        }
        
        context.delete(favbook)
        print("Delete book: \(String(describing: favbook.title))")
        saveContext()
    }
    
    //MARK: Load
    func load() -> [Book] {
        
        let fetchRequest = NSFetchRequest<FavBook>(entityName: "FavBook")
        
        var fav = [Book]()
        
        do {
           let favBooks = try context.fetch(fetchRequest)
//            for core in favBooks {
//                fav.append(Book(from: core))
//  }
            
        } catch {
            print("Couldn't Fetch Fact: \(error.localizedDescription)")
        }
        
        return fav
    }
    
    
    //MARK: Helpers
    
    private func saveContext() {
        do {
            try context.save()
        } catch {
            fatalError(error.localizedDescription)
        }
    }
    
}
