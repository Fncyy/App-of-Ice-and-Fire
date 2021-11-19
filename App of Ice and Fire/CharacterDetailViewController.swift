//
//  CharacterDetailViewController.swift
//  App of Ice and Fire
//
//  Created by user930278 on 11/14/21.
//

import UIKit
import Resolver

class CharacterDetailViewController: UIViewController, UIViewControllerPreviewingDelegate {
    
    // MARK: - Properties

    @Injected private var interactor: IceAndFireInteractor
    
    @IBOutlet weak var tableView: CharacterDetailTableView!
    @IBOutlet weak var backgroundImage: UIImageView!
    
    var characterId: Int!
    
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
        interactor.getCharacter(withId: characterId) { (character) in
            let group = DispatchGroup()
            
            var father: CharacterReference?
            if (character.fatherId != -1) {
                group.enter()
                self.interactor.getCharacter(withId: Int(character.fatherId)) { (characterData) in
                    father = characterData.toCharacterReference()
                    group.leave()
                }
            } else {
                father = nil
            }
            
            var mother: CharacterReference?
            if (character.motherId != -1) {
                group.enter()
                self.interactor.getCharacter(withId: Int(character.motherId)) { (characterData) in
                    mother = characterData.toCharacterReference()
                    group.leave()
                }
            } else {
                mother = nil
            }
            
            var spouse: CharacterReference?
            if (character.spouseId != -1) {
                group.enter()
                self.interactor.getCharacter(withId: Int(character.spouseId)) { (characterData) in
                    spouse = characterData.toCharacterReference()
                    group.leave()
                }
            } else {
                spouse = nil
            }
            
            var allegiances: [HouseReference] = []
            group.enter()
            self.interactor.getHouses(withIds: character.allegianceIds) { (houses) in
                allegiances = houses.map { $0.toHouseReference() }
                group.leave()
            }
            
            var povBooks: [BookReference] = []
            group.enter()
            self.interactor.getBooks(withIds: character.povBookIds) { (books) in
                povBooks = books.map { $0.toBookReference() }
                group.leave()
            }
            
            
            group.notify(queue: .main) {
                DispatchQueue.main.async {
                    self.tableView.updateCharacter(character: character.toCharacterDetail(father: father, mother: mother, spouse: spouse, allegiances: allegiances, povBooks: povBooks))
                }
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
