//
//  BookDetailModel.swift
//  App of Ice and Fire
//
//  Created by user930278 on 11/14/21.
//

import Foundation

struct BookDetail {
    let title: String
    let isbn: String
    let authors: [String]
    let numberOfPages: Int
    let publisher: String
    let country: String
    let mediaType: String
    let released: String
    let povCharacters: [CharacterReference]
}
