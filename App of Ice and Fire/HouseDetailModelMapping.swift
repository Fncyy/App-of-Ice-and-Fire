//
//  HouseDetailModelMapping.swift
//  App of Ice and Fire
//
//  Created by user930278 on 11/15/21.
//

import Foundation

extension House {
    
    func toHouseDetail(currentLord: CharacterReference?, heir: CharacterReference?, overlord: HouseReference?, founder: CharacterReference?, cadetBranches: [HouseReference]) -> HouseDetail {
        let _titles = (titles!.allObjects as! [HouseTitle]).map { $0.title! }
        let _seats = (seats!.allObjects as! [HouseSeat]).map { $0.seat! }
        let _weapons = (ancestralWeapons!.allObjects as! [HouseAncestralWeapon]).map { $0.name! }
        return HouseDetail(
            name: name!,
            region: region!,
            coatOfArms: coatOfArms!.isEmpty ? "Unknown" : coatOfArms!,
            words: words!.isEmpty ? "Unknown" : words!,
            titles: (titles!.allObjects as! [HouseTitle]).map { $0.title! },
            seats: (seats!.allObjects as! [HouseSeat]).map { $0.seat! },
            currentLord: currentLord,
            heir: heir,
            overlord: overlord,
            founded: founded!.isEmpty ? "Unknown" : founded!,
            founder: founder,
            diedOut: diedOut!.isEmpty ? "Unknown" : diedOut!,
            ancestralWeapons: (ancestralWeapons!.allObjects as! [HouseAncestralWeapon]).map { $0.name! },
            cadetBranches: cadetBranches
        )
    }
}
