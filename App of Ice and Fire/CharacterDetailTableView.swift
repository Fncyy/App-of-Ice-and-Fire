//
//  CharacterDetailTableView.swift
//  App of Ice and Fire
//
//  Created by user930278 on 11/14/21.
//

import UIKit

class CharacterDetailTableView: UITableView, UITableViewDelegate, UITableViewDataSource {
    
    // MARK: - Properties
    
    private var character: CharacterDetail!
    var viewController: CharacterDetailViewController!
    private var navigationViews: [IndexPath : UIViewController] = [:]
    private let storyBoard = UIStoryboard(name: "Main", bundle: nil)
    
    func updateCharacter(character: CharacterDetail) {
        self.character = character
        delegate = self
        dataSource = self
        reloadData()
    }
    
    // MARK: - Table view data source
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 8
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 1:
            return "Titles"
        case 2:
            return "Aliases"
        case 3:
            return "Relatives"
        case 4:
            return "Allegiances"
        case 5:
            return "Pov books"
        case 6:
            return "Played in"
        case 7:
            return "Played by"
        default:
            return "General"
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 1:
            return character.titles.count
        case 2:
            return character.aliases.count
        case 3:
            return 3
        case 4:
            return character.allegiances.count
        case 5:
            return character.povBooks.count
        case 6:
            return character.tvSeries.count
        case 7:
            return character.playedBy.count
        default:
            return 4
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 1, 2, 6, 7:
            let cell = tableView.dequeueReusableCell(withIdentifier: "CharacterDetailTableViewCell", for: indexPath) as! CharacterDetailTableViewCell
            return fillSimpleTextData(cell, indexPath)
        case 3:
            let cell = tableView.dequeueReusableCell(withIdentifier: "CharacterDetailLabeledNavigableTableViewCell", for: indexPath) as! CharacterDetailLabeledNavigableToHouseTableViewCell
            return fillFamilyData(cell, indexPath)
        case 4:
            let cell = tableView.dequeueReusableCell(withIdentifier: "CharacterDetailNavigableToHouseTableViewCell", for: indexPath) as! CharacterDetailNavigableToHouseTableViewCell
            cell.houseLabel.text = character.allegiances[indexPath.row].name
            return cell
        case 5:
            let cell = tableView.dequeueReusableCell(withIdentifier: "CharacterDetailNavigableToBookTableViewCell", for: indexPath) as! CharacterDetailNavigableToBookTableViewCell
            cell.bookLabel.text = character.povBooks[indexPath.row].title
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "CharacterDetailLabeledTableViewCell", for: indexPath) as! CharacterDetailLabeledTableViewCell
            return fillGeneralData(cell, indexPath)
        }
    }
    
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        switch indexPath.section {
        case 3:
            switch indexPath.row {
            case 0:
                return character.father == nil ? nil : indexPath
            case 1:
                return character.mother == nil ? nil : indexPath
            default:
                return character.spouse == nil ? nil : indexPath
            }
        case 4, 5:
            return indexPath
        default:
            return nil
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewController.navigationController?.pushViewController(instantiateViewController(at: indexPath), animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func instantiateViewController(at indexPath: IndexPath) -> UIViewController {
        if let viewController = navigationViews[indexPath] {
            return viewController
        }
        switch indexPath.section {
        case 3:
            let characterDetail = storyBoard.instantiateViewController(identifier: "CharacterDetail") as! CharacterDetailViewController
            navigationViews[indexPath] = characterDetail
            let char: CharacterReference
            switch indexPath.row {
            case 0:
                char = character.father!
            case 1:
                char = character.mother!
            default:
                char = character.spouse!
            }
            characterDetail.characterId = char.id
            characterDetail.title = char.name
            return characterDetail
        case 4:
            let houseDetail = storyBoard.instantiateViewController(identifier: "HouseDetail") as! HouseDetailViewController
            navigationViews[indexPath] = houseDetail
            let house = character.allegiances[indexPath.row]
            houseDetail.houseId = house.id
            houseDetail.title = house.name
            return houseDetail
        default:
            let bookDetail = storyBoard.instantiateViewController(identifier: "BookDetail") as! BookDetailViewController
            navigationViews[indexPath] = bookDetail
            let book = character.povBooks[indexPath.row]
            bookDetail.bookId = book.id
            bookDetail.title = book.title
            return bookDetail
        }
    }
    
    private func fillSimpleTextData(_ cell: CharacterDetailTableViewCell, _ indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 1:
            cell.titleLabel.text = character.titles[indexPath.row]
        case 2:
            cell.titleLabel.text = character.aliases[indexPath.row]
        case 6:
            cell.titleLabel.text = character.tvSeries[indexPath.row]
        default:
            cell.titleLabel.text = character.playedBy[indexPath.row]
        }
        return cell
    }
    
    private func fillFamilyData(_ cell: CharacterDetailLabeledNavigableToHouseTableViewCell, _ indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            cell.titleLabel.text = "Father"
            if let name = character.father?.name {
                cell.detailLabel.text = name
            } else {
                cell.detailLabel.text = "Unknown"
                cell.chevronImage.tintColor = UIColor.gray
                cell.chevronImage.alpha = 0.5
            }
        case 1:
            cell.titleLabel.text = "Mother"
            if let name = character.mother?.name {
                cell.detailLabel.text = name
            } else {
                cell.detailLabel.text = "Unknown"
                cell.chevronImage.tintColor = UIColor.gray
                cell.chevronImage.alpha = 0.5
            }
        default:
            cell.titleLabel.text = "Spouse"
            if let name = character.spouse?.name {
                cell.detailLabel.text = name
            } else {
                cell.detailLabel.text = "Unknown"
                cell.chevronImage.tintColor = UIColor.gray
                cell.chevronImage.alpha = 0.5
            }
        }
        return cell
    }
    
    private func fillGeneralData(_ cell: CharacterDetailLabeledTableViewCell, _ indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            cell.titleLabel.text = "Gender"
            cell.detailLabel.text = character.gender ?? "Unknown"
        case 1:
            cell.titleLabel.text = "Culture"
            cell.detailLabel.text = character.culture ?? "Unknown"
        case 2:
            cell.titleLabel.text = "Born"
            cell.detailLabel.text = character.born ?? "Unknown"
        default:
            cell.titleLabel.text = "Died"
            cell.detailLabel.text = character.died ?? "Unknown"
        }
        return cell
    }
}
