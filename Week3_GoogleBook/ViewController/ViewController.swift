//
//  ViewController.swift
//  Week3_GoogleBook
//
//  Created by Sky on 9/15/19.
//  Copyright © 2019 Sky. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let searchController = UISearchController(searchResultsController: nil)
    var viewModel = ViewModel()
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupMain()
    }
    
    private func setupMain() {
        viewModel.get(search: "Donald+Trump")
        viewModel.delegate = self
        NotificationCenter.default.addObserver(forName: Notification.Name.BookNotification, object: nil, queue: .main) { note in
            guard let userInfo = note.userInfo as? [String:ViewModel] else { return }
            
            self.viewModel = userInfo["ViewModel"]!
            
        }
        
        self.searchController.dimsBackgroundDuringPresentation = false
        self.searchController.searchBar.placeholder = "search the book.."
        self.searchController.searchBar.delegate = self
        
        self.navigationItem.hidesSearchBarWhenScrolling = false
        self.navigationItem.searchController = self.searchController
        self.definesPresentationContext = true
        
        
    }
}


extension ViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchText = searchBar.text?.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else { return }
        
        viewModel.get(search: searchText)
        
       // navigationItem.searchController?.isActive = false
        
    }
    
}


extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.books.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: BookTableCell.identifier, for: indexPath) as! BookTableCell
        let book = viewModel.books[indexPath.row]
        cell.book = book
        return cell
    }
    
    
}

extension ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return UITableView.automaticDimension
        return 112
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let book = viewModel.books[indexPath.row]
        viewModel.book = book
        goToDetail(with: viewModel)
    }
    
}

extension ViewController: ViewModelDelegate {
    func update() {
      
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    
}
