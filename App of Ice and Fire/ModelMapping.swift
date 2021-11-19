import Foundation
import UIKit
import CoreData

// MARK: - Helper

extension String {
    private func shorten(byPrefix prefix: String) -> String {
        guard hasPrefix(prefix) else { return self }
        return String(dropFirst(prefix.count))
    }
    
    func valid() -> String? {
        return self.isEmpty ? nil : self
    }
    
    func shortenBookId() -> Int16? {
        let prefixLong = NetworkDataSource.BASE_URL + NetworkDataSource.BOOKS_URL
        let prefixShort = NetworkDataSource.SHORT_URL + NetworkDataSource.BOOKS_URL
        return Int16(shorten(byPrefix: prefixLong)) ?? Int16(shorten(byPrefix: prefixShort))
    }
    
    func shortenCharacterId() -> Int16? {
        let prefixLong = NetworkDataSource.BASE_URL + NetworkDataSource.CHARACTERS_URL
        let prefixShort = NetworkDataSource.SHORT_URL + NetworkDataSource.CHARACTERS_URL
        return Int16(shorten(byPrefix: prefixLong)) ?? Int16(shorten(byPrefix: prefixShort))
    }
    
    func shortenHouseId() -> Int16? {
        let prefixLong = NetworkDataSource.BASE_URL + NetworkDataSource.HOUSES_URL
        let prefixShort = NetworkDataSource.SHORT_URL + NetworkDataSource.HOUSES_URL
        return Int16(shorten(byPrefix: prefixLong)) ?? Int16(shorten(byPrefix: prefixShort))
    }
}

// MARK: - Network to domain

extension NetworkBookModel {
    
    func toBook(withContext context: NSManagedObjectContext) -> Book {
        let book = Book(context: context)
        book.addToAuthors(
            NSOrderedSet(array: authors.map { author in
                let bookAuthor = BookAuthor(context: context)
                bookAuthor.book = book
                bookAuthor.name = author
                return bookAuthor
            })
        )
        book.addToPovCharacters(
            NSOrderedSet(array: povCharacterUrls.map { characterId in
                let povCharacter = BookPovCharacter(context: context)
                povCharacter.book = book
                povCharacter.identifier = characterId.shortenCharacterId()!
                return povCharacter
            })
        )
        book.country = country
        book.identifier = url.shortenBookId()!
        book.isbn = isbn
        book.mediaType = mediaType
        book.numberOfPages = Int16(numberOfPages)
        book.publisher = publisher
        book.released = String(released.prefix(10))
        book.title = title
        return book
    }
}

extension NetworkCharacterModel {
    
    func toCharacter(withContext context: NSManagedObjectContext) -> Character {
        let character = Character(context: context)
        character.addToAliases(
            NSSet(array: aliases.map { alias in
                let characterAlias = CharacterAlias(context: context)
                characterAlias.alias = alias
                characterAlias.character = character
                return characterAlias
            })
        )
        character.addToAllegiances(
            NSSet(array: allegiances.map { allegiance in
                let characterAllegiance = CharacterAllegiance(context: context)
                characterAllegiance.character = character
                characterAllegiance.houseId = allegiance.shortenHouseId()!
                return characterAllegiance
            })
        )
        character.addToPlayedBy(
            NSOrderedSet(array: playedBy.map { name in
                let characterPlayedBy = CharacterPlayedBy(context: context)
                characterPlayedBy.character = character
                characterPlayedBy.name = name
                return characterPlayedBy
            })
        )
        character.addToPovBooks(
            NSOrderedSet(array: povBookUrls.map { book in
                let characterPovBook = CharacterPovBook(context: context)
                characterPovBook.bookId = book.shortenBookId()!
                characterPovBook.character = character
                return characterPovBook
            })
        )
        character.addToTitles(
            NSSet(array: titles.map { title in
                let characterTitle = CharacterTitle(context: context)
                characterTitle.character = character
                characterTitle.title = title
                return characterTitle
            })
        )
        character.addToTvSeasons(
            NSOrderedSet(array: tvSeries.map { season in
                let characterTvSeason = CharacterTvSeason(context: context)
                characterTvSeason.character = character
                characterTvSeason.season = season
                return characterTvSeason
            })
        )
        character.born = born.valid()
        character.culture = culture.valid()
        character.died = died.valid()
        character.fatherId = father.shortenCharacterId() ?? -1
        character.gender = gender.valid()
        character.identifier = url.shortenCharacterId()!
        character.motherId = mother.shortenCharacterId() ?? -1
        character.name = name.valid()
        character.spouseId = spouse.shortenCharacterId() ?? -1
        return character
    }
}

extension NetworkHouseModel {
    
    func toHouse(withContext context: NSManagedObjectContext) -> House {
        let house = House(context: context)
        house.identifier = url.shortenHouseId()!
        house.name = name
        house.region = region
        house.coatOfArms = coatOfArms
        house.words = words
        house.addToTitles(
            NSSet(array: titles.map{ (title) in
                let houseTitle = HouseTitle(context: context)
                houseTitle.house = house
                houseTitle.title = title
                return houseTitle
            })
        )
        house.addToSeats(
            NSSet(array: seats.map{ seat in
                let houseSeat = HouseSeat(context: context)
                houseSeat.house = house
                houseSeat.seat = seat
                return houseSeat
            })
        )
        house.currentLordId = currentLordUrl.shortenCharacterId() ?? -1
        house.heirId = heirUrl.shortenCharacterId() ?? -1
        house.overlordId = overlordUrl.shortenHouseId() ?? -1
        house.founded = founded
        house.founderId = founderUrl.shortenCharacterId() ?? -1
        house.diedOut = diedOut
        house.addToAncestralWeapons(
            NSSet(array: ancestralWeapons.map { weapon in
                let ancestralWeapon = HouseAncestralWeapon(context: context)
                ancestralWeapon.house = house
                ancestralWeapon.name = weapon
                return ancestralWeapon
            })
        )
        house.addToCadetBranches(
            NSSet(array: cadetBranchUrls.map { cadetBranch in
                let houseCadetBranch = HouseCadetBranch(context: context)
                houseCadetBranch.house = house
                houseCadetBranch.houseId = cadetBranch.shortenHouseId() ?? -1
                return houseCadetBranch
            })
        )
        return house
    }
}
