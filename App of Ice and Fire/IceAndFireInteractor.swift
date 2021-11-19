//
//  IceAndFireInteractor.swift
//  App of Ice and Fire
//
//  Created by user930278 on 11/5/21.
//

import Foundation
import Resolver

class IceAndFireInteractor {
    
    // MARK: - Properties
    
    @Injected var networkDataSource: AnApiOfIceAndFireAPI
    @Injected var diskDataSource: DiskDataSource
    private var context = AppDelegate.managedContext
    
    // MARK: - Books
    
    func getBooks(atPage page: Int, completionCallback: @escaping ([Book]) -> Void) {
        networkDataSource.getBooks(atPage: page) { (networkBookList) in
            let bookList = self.diskDataSource.batchInsertBooks(networkBookList)
            completionCallback(bookList)
        }
    }
    
    func getBooks(withIds idList: [Int], completionCallback: @escaping ([Book]) -> Void) {
        var books: [Book] = []
        
        let group = DispatchGroup()
        
        for id in idList {
            group.enter()
            getBook(withId: id) { (book) in
                books.append(book)
                group.leave()
            }
        }
        
        group.notify(queue: .main) {
            completionCallback(books)
        }
    }
    
    func getBook(withId id: Int, completionCallback: @escaping (Book) -> Void) {
        let book = diskDataSource.fetchBook(withId: Int16(id))
        if book != nil {
            completionCallback(book!)
            return
        }
        networkDataSource.getBook(withId: id) { (networkBook) in
            let book = self.diskDataSource.insertBook(networkBook)
            completionCallback(book)
        }
    }
    
    // MARK: - Characters
    
    func getCharacters(atPage page: Int, completionCallback: @escaping ([Character], Int) -> Void) {
        networkDataSource.getCharacters(atPage: page) { (networkCharacterList, lastPage) in
            let characterList = self.diskDataSource.batchInsertCharacters(networkCharacterList)
            completionCallback(characterList, lastPage)
        }
    }
    
    func getCharacters(withIds idList: [Int], completionCallback: @escaping ([Character]) -> Void) {
        var characters: [Character] = []
        
        let group = DispatchGroup()
        
        for id in idList {
            group.enter()
            getCharacter(withId: id) { (character) in
                characters.append(character)
                group.leave()
            }
        }
        
        group.notify(queue: .main) {
            completionCallback(characters)
        }
    }
    
    func getCharacter(withId id: Int, completionCallback: @escaping (Character) -> Void) {
        let character = diskDataSource.fetchCharacter(withId: Int16(id))
        if character != nil {
            completionCallback(character!)
            return
        }
        networkDataSource.getCharacter(withId: id) { networkCharacter in
            let character = self.diskDataSource.insertCharacter(networkCharacter)
            completionCallback(character)
        }
    }
    
    // MARK: - Houses
    
    func getHouses(atPage page: Int, completionCallback: @escaping ([House], Int) -> Void) {
        networkDataSource.getHouses(atPage: page) { (networkHouseList, lastPage) in
            let houseList = self.diskDataSource.batchInsertHouses(networkHouseList)
            completionCallback(houseList, lastPage)
        }
    }
    
    func getHouses(withIds idList: [Int], completionCallback: @escaping ([House]) -> Void) {
        var houses: [House] = []
        
        let group = DispatchGroup()
        
        for id in idList {
            group.enter()
            getHouse(withId: id) { (house) in
                houses.append(house)
                group.leave()
            }
        }
        
        group.notify(queue: .main) {
            completionCallback(houses)
        }
    }
    
    func getHouse(withId id: Int, completionCallback: @escaping (House) -> Void) {
        let house = diskDataSource.fetchHouse(withId: Int16(id))
        if house != nil {
            completionCallback(house!)
            return
        }
        networkDataSource.getHouse(withId: id) { networkHouse in
            let house = self.diskDataSource.insertHouse(networkHouse)
            completionCallback(house)
        }
    }
}
