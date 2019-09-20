//
//  DetailViewController.swift
//  Week3_GoogleBook
//
//  Created by Sky on 9/20/19.
//  Copyright © 2019 Sky. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var bookImage: UIImageView!
    @IBOutlet weak var bookTitle: UILabel!
    @IBOutlet weak var bookAuthor: UILabel!
    @IBOutlet weak var bookDescription: UITextView!
    
    var vm: ViewModel!
 //   var book: Book
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupDetail()
    }
    
    private func setupDetail() {
        bookTitle.text = vm.book.volumeInfo.title
        vm.book.getBigImage { [weak self] img in
            self?.bookImage.image = img
        }
        bookAuthor.text = "By: " + vm.book.volumeInfo.authors[0]
        bookDescription.text = vm.book.volumeInfo.description
    }


}
