//
//  HousesTableViewController.swift
//  App of Ice and Fire
//
//  Created by user930278 on 11/13/21.
//

import UIKit
import Resolver

class HousesTableViewController: UITableViewController {
    
    // MARK: - Properties
    
    @Injected private var interactor: IceAndFireInteractor
    private var houses: [HouseListItem] = []
    private var currentPage: Int = 1
    private var lastPage: Int!
    private var isPaginating = true
    
    // MARK: - View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        lastPage = 1
        
        interactor.getHouses(atPage: currentPage, completionCallback: { (houses, lastPage) in
            DispatchQueue.main.async {
                self.lastPage = lastPage
                self.houses = houses.map { $0.toHouseListItem() }
                self.tableView.reloadData()
                self.isPaginating = false
            }
        })
        
        applyImageBackgroundToTheNavigationBar()
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return houses.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HousesTableViewCell", for: indexPath) as! HousesTableViewCell
        
        let house = houses[indexPath.row]
        
        cell.nameLabel.text = house.name
        cell.regionLabel.text = house.region
        
        return cell
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if currentPage == lastPage {
            return
        }
        let position = scrollView.contentOffset.y
        if !isPaginating && position > (tableView.contentSize.height - 100 - scrollView.frame.size.height) {
            isPaginating = true
            currentPage += 1
            interactor.getHouses(atPage: currentPage, completionCallback: { (houses, lastPage) in
                DispatchQueue.main.async {
                    self.lastPage = lastPage
                    self.houses += houses.map { $0.toHouseListItem() }
                    self.tableView.reloadData()
                    self.isPaginating = false
                }
            })
        }
    }

    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if let houseDetail = segue.destination as? HouseDetailViewController, let selectedIndex = tableView.indexPathForSelectedRow {
            let house = houses[selectedIndex.row]
            houseDetail.houseId = house.id
            houseDetail.title = house.name
        }
    }
}
