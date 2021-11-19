//
//  DiskDataSource.swift
//  App of Ice and Fire
//
//  Created by user930278 on 11/10/21.
//

import Foundation
import CoreData

class DiskDataSource {
    
    private let managedContext = AppDelegate.managedContext
    
    // MARK: - Book
    
    func insertBook(_ networkBook: NetworkBookModel) -> Book {
        let book = fetchBook(withId: networkBook.url.shortenBookId()!) ?? networkBook.toBook(withContext: managedContext)
        do {
            if managedContext.hasChanges {
                try managedContext.save()
            }
        } catch let exception {
            print(exception)
        }
        return book
    }
    
    func batchInsertBooks(_ networkBooks: [NetworkBookModel]) -> [Book] {
        return networkBooks.map { (networkBook) in
            self.insertBook(networkBook)
        }
    }
    
    func fetchBook(withId id: Int16) -> Book? {
        let fetchRequest: NSFetchRequest<Book> = Book.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "identifier == \(id)")
        do {
            let books = try managedContext.fetch(fetchRequest)
            return books.isEmpty ? nil : books[0]
        } catch let exception {
            print(exception)
        }
        return nil
    }
    
    // MARK: - Character
    
    func insertCharacter(_ networkCharacter: NetworkCharacterModel) -> Character {
        let character = fetchCharacter(withId: networkCharacter.url.shortenCharacterId()!) ?? networkCharacter.toCharacter(withContext: managedContext)
        do {
            if managedContext.hasChanges {
                try managedContext.save()
            }
        } catch let exception {
            print(exception)
        }
        return character
    }
    
    func batchInsertCharacters(_ networkCharacters: [NetworkCharacterModel]) -> [Character] {
        return networkCharacters.map { (networkCharacter) in
            self.insertCharacter(networkCharacter)
        }
    }
    
    func fetchCharacter(withId id: Int16) -> Character? {
        let fetchRequest: NSFetchRequest<Character> = Character.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "identifier == \(id)")
        do {
            let characters = try managedContext.fetch(fetchRequest)
            return characters.isEmpty ? nil : characters[0]
        } catch let exception {
            print(exception)
        }
        return nil
    }
    
    // MARK: - House
    
    func insertHouse(_ networkHouse: NetworkHouseModel) -> House {
        let house = fetchHouse(withId: networkHouse.url.shortenHouseId()!) ?? networkHouse.toHouse(withContext: managedContext)
        do {
            if managedContext.hasChanges {
                try managedContext.save()
            }
        } catch let exception {
            print(exception)
        }
        return house
    }
    
    func batchInsertHouses(_ networkHouses: [NetworkHouseModel]) -> [House] {
        return networkHouses.map { (networkHouse) in
            self.insertHouse(networkHouse)
        }
    }
    
    func fetchHouse(withId id: Int16) -> House? {
        let fetchRequest: NSFetchRequest<House> = House.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "identifier == \(id)")
        do {
            let houses = try managedContext.fetch(fetchRequest)
            return houses.isEmpty ? nil : houses[0]
        } catch let exception {
            print(exception)
        }
        return nil
    }
}
