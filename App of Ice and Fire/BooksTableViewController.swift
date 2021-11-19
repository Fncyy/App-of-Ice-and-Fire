//
//  BooksTableViewController.swift
//  App of Ice and Fire
//
//  Created by user930278 on 11/6/21.
//

import UIKit
import Resolver

class BooksTableViewController: UITableViewController {
    
    // MARK: - Properties
    
    @Injected private var interactor: IceAndFireInteractor
    private var books: [BookListItem] = []
    
    // MARK: - View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tabBar = self.tabBarController!.tabBar
        tabBar.selectionIndicatorImage = UIImage().createSelectionIndicator(
            color: UIColor.init(named: "Background")!,
            size: CGSize(
                width: tabBar.frame.width/CGFloat(tabBar.items!.count),
                height: tabBar.frame.height
            ),
            lineWidth: 2.0
        )
        
        interactor.getBooks(atPage: 1, completionCallback: { (books) in
            DispatchQueue.main.async {
                self.books = books.map { $0.toBookListItem() }
                self.tableView.reloadData()
            }
        })
        
        applyImageBackgroundToTheNavigationBar()
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return books.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BooksTableViewCell", for: indexPath) as! BooksTableViewCell
        
        let book = books[indexPath.row]
        
        cell.titleLabel.text = book.title
        cell.releasedLabel.text = book.released
        
        return cell
    }
    
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        
        if let bookDetail = segue.destination as? BookDetailViewController, let selectedIndex = tableView.indexPathForSelectedRow {
            let book = books[selectedIndex.row]
            bookDetail.bookId = book.id
            bookDetail.title = book.title
        }
    }
    
    
}
