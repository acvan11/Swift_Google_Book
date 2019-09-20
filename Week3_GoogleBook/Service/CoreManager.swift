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
typealias FavBookHandler = ([FavBook]) -> Void

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
    
    
    //MARK: Save'
    /*
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
 */
    func save(_ book: FavBook) {
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
    func load(completion: @escaping FavBookHandler) -> [FavBook] {
        
        let fetchRequest = NSFetchRequest<FavBook>(entityName: "FavBook")
        
        do {
            let favBooks: [FavBook] = try context.fetch(fetchRequest)
            return favBooks
        }
        catch {
            
        }
        return []
    }
    /*
        var fav: [Book] = [Book]()
        
        do {
            let favBooks: [FavBook] = try context.fetch(fetchRequest)
            for core in favBooks {
                // Book init needs Decoder
                // 'core' is a FavBook
                // objective:
                // turn FavBook ~> Book
                // FavBook? ~> Core Data Entity Model
                // Book? ~> Another Custom Model
                // Solutions:
                // 1. Adapt FavBook into a Book
                // 2. Only use one Model
                
                // 2. Decodable Core Data.
                // A. Decoder - Decodable
                // B. NSManagedObjectContext - Core Data
                fav.append(Book.init(from: <#T##Decoder#>))
            }
            completion(fav)
            
        } catch {
            print("Couldn't Fetch Fact: \(error.localizedDescription)")
            completion([])
        }
        
        return fav
    }
    */
    
    //MARK: Helpers
    
    private func saveContext() {
        do {
            try context.save()
        } catch {
            fatalError(error.localizedDescription)
        }
    }
    
}
