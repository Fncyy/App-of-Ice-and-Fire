//
//  CharacterDetailModel.swift
//  App of Ice and Fire
//
//  Created by user930278 on 11/14/21.
//

import Foundation

struct CharacterDetail {
    let name: String?
    let gender: String?
    let culture: String?
    let born: String?
    let died: String?
    let titles: [String]
    let aliases: [String]
    let father: CharacterReference?
    let mother: CharacterReference?
    let spouse: CharacterReference?
    let allegiances: [HouseReference]
    let povBooks: [BookReference]
    let tvSeries: [String]
    let playedBy: [String]
}
