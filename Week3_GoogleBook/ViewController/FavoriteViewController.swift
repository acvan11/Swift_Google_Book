//
//  FavoriteViewController.swift
//  Week3_GoogleBook
//
//  Created by Sky on 9/20/19.
//  Copyright © 2019 Sky. All rights reserved.
//

import UIKit

class FavoriteViewController: UIViewController {

    @IBOutlet weak var favoriteCollectionView: UICollectionView!
    
    var viewModel = ViewModel() {
        didSet {
            DispatchQueue.main.async {
                self.favoriteCollectionView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }


}

extension FavoriteViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.favbooks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    
}

extension FavoriteViewController: UITableViewDelegate {
    
}

extension FavoriteViewController: FavoriteDelegate {
    func update() {
        DispatchQueue.main.async {
            self.favoriteCollectionView.reloadData()
        }
    }
    
    
}
