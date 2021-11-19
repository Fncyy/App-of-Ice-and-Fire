//
//  BookDetailTableView.swift
//  App of Ice and Fire
//
//  Created by user930278 on 11/13/21.
//

import Foundation
import UIKit

class BookDetailTableView: UITableView, UITableViewDelegate, UITableViewDataSource {
    
    // MARK: - Properties
    
    private var book: BookDetail!
    var viewController: BookDetailViewController!
    private var navigationViews: [IndexPath : UIViewController] = [:]
    private let storyBoard = UIStoryboard(name: "Main", bundle: nil)
    
    func updateBook(book: BookDetail) {
        self.book = book
        delegate = self
        dataSource = self
        reloadData()
    }
    
    // MARK: - Table view data source
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 1:
            return "Authors"
        case 2:
            return "Pov Characters"
        default:
            return "General"
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 1:
            return book.authors.count
        case 2:
            return book.povCharacters.count
        default:
            return 6
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "BookDetailTableViewCell", for: indexPath) as! BookDetailTableViewCell
            cell.titleLabel.text = book.authors[indexPath.row]
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: "BookDetailNavigableTableViewCell", for: indexPath) as! BookDetailNavigableTableViewCell
            cell.titleLabel.text = book.povCharacters[indexPath.row].name
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "BookDetailLabeledTableViewCell", for: indexPath) as! BookDetailLabeledTableViewCell
            fillGeneralSection(cell, indexPath)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        return indexPath.section == 2 ? indexPath : nil
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewController.navigationController?.pushViewController(instantiateViewController(at: indexPath), animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func instantiateViewController(at indexPath: IndexPath) -> UIViewController {
        if let viewController = navigationViews[indexPath] {
            return viewController
        }
        let characterDetail = storyBoard.instantiateViewController(withIdentifier: "CharacterDetail") as! CharacterDetailViewController
        navigationViews[indexPath] = characterDetail
        let character = book.povCharacters[indexPath.row]
        characterDetail.characterId = character.id
        characterDetail.title = character.name
        return characterDetail
    }
    
    private func fillGeneralSection(_ cell: BookDetailLabeledTableViewCell, _ indexPath: IndexPath) {
        switch indexPath.row {
        case 1:
            cell.titleLabel.text = "Publisher"
            cell.detailLabel.text = book.publisher
        case 2:
            cell.titleLabel.text = "Country"
            cell.detailLabel.text = book.country
        case 3:
            cell.titleLabel.text = "Media type"
            cell.detailLabel.text = book.mediaType
        case 4:
            cell.titleLabel.text = "Released"
            cell.detailLabel.text = book.released
        case 5:
            cell.titleLabel.text = "Pages"
            cell.detailLabel.text = "\(book.numberOfPages)"
        default:
            cell.titleLabel.text = "ISBN"
            cell.detailLabel.text = book.isbn
        }
    }
}
