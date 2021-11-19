//
//  AnApiOfIceAndFireAPI.swift
//  App of Ice and Fire
//
//  Created by user930278 on 11/5/21.
//

import Foundation

protocol AnApiOfIceAndFireAPI {
    func getBooks(atPage page: Int, completionCallback: @escaping ([NetworkBookModel]) -> Void)
    func getCharacters(atPage page: Int, completionCallback: @escaping ([NetworkCharacterModel], Int) -> Void)
    func getHouses(atPage page: Int, completionCallback: @escaping ([NetworkHouseModel], Int) -> Void)
    func getBook(withId id: Int, completionCallback: @escaping (NetworkBookModel) -> Void)
    func getCharacter(withId id: Int, completionCallback: @escaping (NetworkCharacterModel) -> Void)
    func getHouse(withId id: Int, completionCallback: @escaping (NetworkHouseModel) -> Void)
}
