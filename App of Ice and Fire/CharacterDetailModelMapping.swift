//
//  CharacterDetailModelMapping.swift
//  App of Ice and Fire
//
//  Created by user930278 on 11/14/21.
//

import Foundation

extension Character {
    var allegianceIds: [Int] {
        return (allegiances!.allObjects as! [CharacterAllegiance]).map { Int($0.houseId) }
    }
    
    var povBookIds: [Int] {
        return (povBooks!.array as! [CharacterPovBook]).map { Int($0.bookId) }
    }
    
    func toCharacterDetail(father: CharacterReference?, mother: CharacterReference?, spouse: CharacterReference?, allegiances: [HouseReference], povBooks: [BookReference]) -> CharacterDetail {
        return CharacterDetail(
            name: name,
            gender: gender,
            culture: culture,
            born: born,
            died: died,
            titles: (titles!.allObjects as! [CharacterTitle]).map{ $0.title! == "" ? "Has no title" : $0.title! },
            aliases: (aliases!.allObjects as! [CharacterAlias]).map { $0.alias! == "" ? "Has no alias" : $0.alias! },
            father: father,
            mother: mother,
            spouse: spouse,
            allegiances: allegiances,
            povBooks: povBooks,
            tvSeries: (tvSeasons!.array as! [CharacterTvSeason]).map { $0.season! == "" ? "Did not appear in the series" : $0.season! },
            playedBy: (playedBy!.array as! [CharacterPlayedBy]).map { $0.name! == "" ? "Did not appear in the series" : $0.name! }
        )
    }
}
