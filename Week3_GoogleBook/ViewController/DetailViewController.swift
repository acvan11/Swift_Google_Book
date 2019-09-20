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
    @IBOutlet weak var favButton: UIButton!
    
    var vm: ViewModel!
 //   var book: Book
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        print( text.elementsEqual("Like"))
        setupDetail()
    }
    
    private func setupDetail() {
        bookTitle.text = vm.book.title
        vm.book.getBigImage { [weak self] img in
            self?.bookImage.image = img
        }
        bookAuthor.text = "By: " + (vm.book.author ?? "")
        bookDescription.text = vm.book.desc
    }


    @IBAction func favButtonTapped(_ sender: UIButton) {
        var text = favButton.titleLabel!.text!
        if text.elementsEqual("Like") {
            favButton.setTitle("Unlike", for: .normal)
             favButton.setTitleColor(.red, for: .normal)
            vm.favorite(book: vm.book)
        } else {
            favButton.setTitle("Like", for: .normal)
            favButton.setTitleColor(.white, for: .normal)
            vm.unfav(book: vm.book)
        }
    }
}
