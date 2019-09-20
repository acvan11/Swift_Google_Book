//
//  ViewModel.swift
//  Week3_GoogleBook
//
//  Created by Sky on 9/16/19.
//  Copyright © 2019 Sky. All rights reserved.
//

import Foundation

protocol ViewModelDelegate: class {
    func update()
}

final class ViewModel {
    weak var delegate: ViewModelDelegate?
    static let shared = ViewModel()
    private init() {}
    
    var books = [Book]() {
        didSet {
            //let userInfo: [String:ViewModel] = ["ViewModel":self]
            //NotificationCenter.default.post(name: Notification.Name.BookNotification, object: nil, userInfo: userInfo)
        delegate?.update()
        }
        
    }
    
    var book: Book!
    
    func get(search: String) {
        BookService.shared.getBooks(for: search) {[weak self] bookss in
            self?.books = bookss
            print("Book Count : \(bookss.count)")
            
            
        }
    }
}
