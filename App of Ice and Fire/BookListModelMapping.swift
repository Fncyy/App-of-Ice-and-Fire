//
//  BookListModelMapping.swift
//  App of Ice and Fire
//
//  Created by user930278 on 11/13/21.
//

import Foundation

extension Book {
    func toBookListItem() -> BookListItem {
        return BookListItem(id: Int(identifier), title: title!, released: released!)
    }
}
