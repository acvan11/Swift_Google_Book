//
//  BookTableCell.swift
//  Week3_GoogleBook
//
//  Created by Sky on 9/16/19.
//  Copyright © 2019 Sky. All rights reserved.
//

import UIKit

class BookTableCell: UITableViewCell {

    @IBOutlet weak var bookImage: UIImageView!
    @IBOutlet weak var bookTitleLabel: UILabel!
    @IBOutlet weak var bookauthorLabel: UILabel!
    
    static let identifier = "BookTableCell"
    
    var book: Book! {
        didSet {
            bookTitleLabel.text = book.volumeInfo.title
            bookauthorLabel.text = book.volumeInfo.authors[0]
            book.getImage { [weak self] img in
                self?.bookImage.image = img
            }
        }
    }
    override func prepareForReuse() {
         super.prepareForReuse()
    
    }
}
