//
//  HouseDetailTableView.swift
//  App of Ice and Fire
//
//  Created by user930278 on 11/15/21.
//

import UIKit

class HouseDetailTableView: UITableView, UITableViewDataSource, UITableViewDelegate {
    
    // MARK: - Properties
    
    private var house: HouseDetail!
    var viewController: HouseDetailViewController!
    private var navigationViews: [IndexPath : UIViewController] = [:]
    private let storyBoard = UIStoryboard(name: "Main", bundle: nil)
    
    func updateHouse(house: HouseDetail) {
        self.house = house
        delegate = self
        dataSource = self
        reloadData()
    }
    
    // MARK: - Table view data source
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 1:
            return "Titles"
        case 2:
            return "Seats"
        case 3:
            return "Ancestral weapons"
        case 4:
            return "Cadet branches"
        default:
            return "General"
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 1:
            return house.titles.count
        case 2:
            return house.seats.count
        case 3:
            return house.ancestralWeapons.count
        case 4:
            return house.cadetBranches.count
        default:
            return 9
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "HouseDetailTableViewCell", for: indexPath) as! HouseDetailTableViewCell
            let title = house.titles[indexPath.row]
            cell.titleLabel.text = title.isEmpty ? "Has no titles" : title
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: "HouseDetailTableViewCell", for: indexPath) as! HouseDetailTableViewCell
            let title = house.seats[indexPath.row]
            cell.titleLabel.text = title.isEmpty ? "Has no seats" : title
            return cell
        case 3:
            let cell = tableView.dequeueReusableCell(withIdentifier: "HouseDetailTableViewCell", for: indexPath) as! HouseDetailTableViewCell
            let title = house.ancestralWeapons[indexPath.row]
            cell.titleLabel.text = title.isEmpty ? "Has no ancestral weapons" : title
            return cell
        case 4:
            let cell = tableView.dequeueReusableCell(withIdentifier: "HouseDetailNavigableToHouseTableViewCell", for: indexPath) as! HouseDetailNavigableToHouseTableViewCell
            cell.titleLabel.text = house.cadetBranches[indexPath.row].name
            return cell
        default:
            return fillGeneralData(tableView, indexPath)
        }
    }
    
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        switch indexPath.section {
        case 0:
            switch indexPath.row {
            case 3:
                return house.currentLord != nil ? indexPath : nil
            case 4:
                return house.heir != nil ? indexPath : nil
            case 5:
                return house.overlord != nil ? indexPath : nil
            case 7:
                return house.founder != nil ? indexPath : nil
            default:
                return nil
            }
        case 4:
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
        case 0:
            switch indexPath.row {
            case 3:
                let characterDetail = storyBoard.instantiateViewController(withIdentifier: "CharacterDetail") as! CharacterDetailViewController
                navigationViews[indexPath] = characterDetail
                let char = house.currentLord!
                characterDetail.characterId = char.id
                characterDetail.title = char.name
                return characterDetail
            case 4:
                let characterDetail = storyBoard.instantiateViewController(withIdentifier: "CharacterDetail") as! CharacterDetailViewController
                navigationViews[indexPath] = characterDetail
                let char = house.heir!
                characterDetail.characterId = char.id
                characterDetail.title = char.name
                return characterDetail
            case 5:
                let houseDetail = storyBoard.instantiateViewController(withIdentifier: "HouseDetail") as! HouseDetailViewController
                navigationViews[indexPath] = houseDetail
                let overlord = house.overlord!
                houseDetail.houseId = overlord.id
                houseDetail.title = overlord.name
                return houseDetail
            default:
                let characterDetail = storyBoard.instantiateViewController(withIdentifier: "CharacterDetail") as! CharacterDetailViewController
                navigationViews[indexPath] = characterDetail
                let char = house.founder!
                characterDetail.characterId = char.id
                characterDetail.title = char.name
                return characterDetail
            }
        default:
            let houseDetail = storyBoard.instantiateViewController(withIdentifier: "HouseDetail") as! HouseDetailViewController
            navigationViews[indexPath] = houseDetail
            let branch = house.cadetBranches[indexPath.row]
            houseDetail.houseId = branch.id
            houseDetail.title = branch.name
            return houseDetail
        }
    }

    private func fillGeneralData(_ tableView: UITableView, _ indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "HouseDetailLabeledTableViewCell", for: indexPath) as! HouseDetailLabeledTableViewCell
            cell.titleLabel.text = "Region"
            cell.detailLabel.text = house.region
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "HouseDetailLabeledTableViewCell", for: indexPath) as! HouseDetailLabeledTableViewCell
            cell.titleLabel.text = "Crest"
            cell.detailLabel.text = house.coatOfArms
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: "HouseDetailLabeledTableViewCell", for: indexPath) as! HouseDetailLabeledTableViewCell
            cell.titleLabel.text = "Words"
            cell.detailLabel.text = house.words
            return cell
        case 3:
            let cell = tableView.dequeueReusableCell(withIdentifier: "HouseDetailLabeledNavigableTableViewCell", for: indexPath) as! HouseDetailLabeledNavigableTableViewCell
            cell.titleLabel.text = "Lord"
            if let name = house.currentLord?.name{
                cell.detailLabel.text = name
            } else {
                cell.detailLabel.text = "Unknown"
                cell.chevronImage.tintColor = UIColor.gray
                cell.chevronImage.alpha = 0.5
            }
            return cell
        case 4:
            let cell = tableView.dequeueReusableCell(withIdentifier: "HouseDetailLabeledNavigableTableViewCell", for: indexPath) as! HouseDetailLabeledNavigableTableViewCell
            cell.titleLabel.text = "Heir"
            if let name = house.heir?.name{
                cell.detailLabel.text = name
            } else {
                cell.detailLabel.text = "Unknown"
                cell.chevronImage.tintColor = UIColor.gray
                cell.chevronImage.alpha = 0.5
            }
            return cell
        case 5:
            let cell = tableView.dequeueReusableCell(withIdentifier: "HouseDetailLabeledNavigableTableViewCell", for: indexPath) as! HouseDetailLabeledNavigableTableViewCell
            cell.titleLabel.text = "Overlord"
            if let name = house.overlord?.name{
                cell.detailLabel.text = name
            } else {
                cell.detailLabel.text = "Unknown"
                cell.chevronImage.tintColor = UIColor.gray
                cell.chevronImage.alpha = 0.5
            }
            return cell
        case 6:
            let cell = tableView.dequeueReusableCell(withIdentifier: "HouseDetailLabeledTableViewCell", for: indexPath) as! HouseDetailLabeledTableViewCell
            cell.titleLabel.text = "Founded"
            cell.detailLabel.text = house.founded
            return cell
        case 7:
            let cell = tableView.dequeueReusableCell(withIdentifier: "HouseDetailLabeledNavigableTableViewCell", for: indexPath) as! HouseDetailLabeledNavigableTableViewCell
            cell.titleLabel.text = "Founder"
            if let name = house.founder?.name{
                cell.detailLabel.text = name
            } else {
                cell.detailLabel.text = "Unknown"
                cell.chevronImage.tintColor = UIColor.gray
                cell.chevronImage.alpha = 0.5
            }
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "HouseDetailLabeledTableViewCell", for: indexPath) as! HouseDetailLabeledTableViewCell
            cell.titleLabel.text = "Died out"
            cell.detailLabel.text = house.diedOut
            return cell
        }
    }
}
