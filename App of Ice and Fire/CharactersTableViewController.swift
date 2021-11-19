//
//  CharactersTableViewController.swift
//  App of Ice and Fire
//
//  Created by user930278 on 11/12/21.
//

import UIKit
import Resolver

class CharactersTableViewController: UITableViewController {
    
    // MARK: - Properties
    
    @Injected private var interactor: IceAndFireInteractor
    private var characters: [CharacterListItem] = []
    private var currentPage: Int = 1
    private var lastPage: Int!
    private var isPaginating = true
    
    // MARK: - View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        lastPage = 1
        
        interactor.getCharacters(atPage: currentPage, completionCallback: { (characters, lastPage) in
            DispatchQueue.main.async {
                self.lastPage = lastPage
                self.characters = characters.map { $0.toCharacterListItem() }
                self.tableView.reloadData()
                self.isPaginating = false
            }
        })
        
        applyImageBackgroundToTheNavigationBar()
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return characters.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CharactersTableViewCell", for: indexPath) as! CharactersTableViewCell
        
        let character = characters[indexPath.row]
        
        cell.nameLabel.text = character.name ?? "Unknown"
        cell.aliasLabel.text = character.alias ?? ""
        
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
            interactor.getCharacters(atPage: currentPage, completionCallback: { (characters, lastPage) in
                DispatchQueue.main.async {
                    self.lastPage = lastPage
                    self.characters += characters.map { $0.toCharacterListItem() }
                    self.tableView.reloadData()
                    self.isPaginating = false
                }
            })
        }
    }
    
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        
        if let characterDetail = segue.destination as? CharacterDetailViewController, let selectedIndex = tableView.indexPathForSelectedRow {
            let character = characters[selectedIndex.row]
            characterDetail.characterId = character.id
            characterDetail.title = character.name ?? character.alias!
        }
    }
    
    
}
