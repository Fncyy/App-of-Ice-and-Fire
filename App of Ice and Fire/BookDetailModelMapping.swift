//
//  BookDetailModelMapping.swift
//  App of Ice and Fire
//
//  Created by user930278 on 11/13/21.
//

import Foundation

extension Book {
    var povCharacterIds: [Int] {
        let characters = povCharacters!.array as! [BookPovCharacter]
        return characters.map { Int($0.identifier) }
    }
    
    func toBookDetail(withPovCharacters characters: [CharacterReference]) -> BookDetail {
        let authorObjects = authors!.array as! [BookAuthor]
        let authorNames = authorObjects.map { $0.name! }
        return BookDetail(title: title!, isbn: isbn!, authors: authorNames, numberOfPages: Int(numberOfPages), publisher: publisher!, country: country!, mediaType: mediaType!, released: released!, povCharacters: characters)
    }
}
