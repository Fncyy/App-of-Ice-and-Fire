//
//  BaseModelMapping.swift
//  App of Ice and Fire
//
//  Created by user930278 on 11/15/21.
//

import Foundation

extension Character {
    
    func toCharacterReference() -> CharacterReference {
        return CharacterReference(id: Int(identifier), name: name!)
    }
}

extension Book {
    func toBookReference() -> BookReference {
        return BookReference(id: Int(identifier), title: title!)
    }
}

extension House {
    func toHouseReference() -> HouseReference {
        return HouseReference(id: Int(identifier), name: name!)
    }
}
