//
//  HouseDetailModel.swift
//  App of Ice and Fire
//
//  Created by user930278 on 11/15/21.
//

import Foundation

struct HouseDetail {
    let name: String
    let region: String
    let coatOfArms: String
    let words: String
    let titles: [String]
    let seats: [String]
    let currentLord: CharacterReference?
    let heir: CharacterReference?
    let overlord: HouseReference?
    let founded: String
    let founder: CharacterReference?
    let diedOut: String
    let ancestralWeapons: [String]
    let cadetBranches: [HouseReference]    
}
