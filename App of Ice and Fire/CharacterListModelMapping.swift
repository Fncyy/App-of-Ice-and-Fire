//
//  CharacterListModelMapping.swift
//  App of Ice and Fire
//
//  Created by user930278 on 11/13/21.
//

import Foundation

extension Character {
    func toCharacterListItem() -> CharacterListItem {
        let alias = aliases?.anyObject() as? CharacterAlias
        return CharacterListItem(id: Int(identifier), name: name, alias: alias?.alias)
    }
}
