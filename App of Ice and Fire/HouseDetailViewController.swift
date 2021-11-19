//
//  HouseDetailViewController.swift
//  App of Ice and Fire
//
//  Created by user930278 on 11/15/21.
//

import UIKit
import Resolver

class HouseDetailViewController: UIViewController, UIViewControllerPreviewingDelegate {
    
    // MARK: - Properties
    
    @Injected private var interactor: IceAndFireInteractor
    
    @IBOutlet weak var tableView: HouseDetailTableView!
    @IBOutlet weak var backgroundImage: UIImageView!
    
    var houseId: Int!
    
    // MARK: - View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.viewController = self
        fetchDataToPresent()
        
        let blurEffect = UIBlurEffect(style: .regular)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.alpha = 0.75
        blurEffectView.frame = backgroundImage.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        backgroundImage.addSubview(blurEffectView)
    }
    
    private func fetchDataToPresent() {
        interactor.getHouse(withId: houseId) { (house) in
            let group = DispatchGroup()
            
            var currentLord: CharacterReference?
            if house.currentLordId != -1 {
                group.enter()
                self.interactor.getCharacter(withId: Int(house.currentLordId)) { (character) in
                    currentLord = character.toCharacterReference()
                    group.leave()
                }
            } else {
                currentLord = nil
            }
            
            var heir: CharacterReference?
            if house.heirId != -1 {
                group.enter()
                self.interactor.getCharacter(withId: Int(house.heirId)) { (character) in
                    heir = character.toCharacterReference()
                    group.leave()
                }
            } else {
                heir = nil
            }
            
            var overlord: HouseReference?
            if house.overlordId != -1 {
                group.enter()
                self.interactor.getHouse(withId: Int(house.overlordId)) { (houseData) in
                    overlord = houseData.toHouseReference()
                    group.leave()
                }
            } else {
                overlord = nil
            }
            
            var founder: CharacterReference?
            if house.founderId != -1 {
                group.enter()
                self.interactor.getCharacter(withId: Int(house.founderId)) { (character) in
                    founder = character.toCharacterReference()
                    group.leave()
                }
            } else {
                founder = nil
            }
            
            var cadetBranches: [HouseReference] = []
            group.enter()
            self.interactor.getHouses(withIds: (house.cadetBranches!.allObjects as! [HouseCadetBranch]).map { Int($0.houseId) }) { (houses) in
                cadetBranches = houses.map { $0.toHouseReference() }
                group.leave()
            }
            
            group.notify(queue: .main) {
                self.tableView.updateHouse(house: house.toHouseDetail(currentLord: currentLord, heir: heir, overlord: overlord, founder: founder, cadetBranches: cadetBranches))
            }
        }
    }
    
    // MARK: - Previewing
    
    func previewingContext(_ previewingContext: UIViewControllerPreviewing, viewControllerForLocation location: CGPoint) -> UIViewController? {
        guard let indexPath = tableView.indexPathForRow(at: location),
                let cell = tableView.cellForRow(at: indexPath)
                else { return nil }
        previewingContext.sourceRect = cell.frame
        return tableView.instantiateViewController(at: indexPath)
    }
    
    func previewingContext(_ previewingContext: UIViewControllerPreviewing, commit viewControllerToCommit: UIViewController) {
        navigationController?.pushViewController(viewControllerToCommit, animated: true)
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
