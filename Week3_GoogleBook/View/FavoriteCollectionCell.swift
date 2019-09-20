//
//  FavoriteCollectionCell.swift
//  Week3_GoogleBook
//
//  Created by Sky on 9/20/19.
//  Copyright © 2019 Sky. All rights reserved.
//

import UIKit

class FavoriteCollectionCell: UICollectionViewCell {
    
    @IBOutlet weak var BookImage: UIImageView!
    @IBOutlet weak var bookAuthor: UILabel!
    
    static let identifier = "FavoriteCollectionCell"
    
    var book: Book! {
        didSet{
        bookAuthor.text = book.volumeInfo.authors[0]
            book.getImage{ [weak self] img in
                self?.BookImage.image = img
            }
        }
    }
}
