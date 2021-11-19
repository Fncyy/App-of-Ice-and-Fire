//
//  HouseListModelMapping.swift
//  App of Ice and Fire
//
//  Created by user930278 on 11/13/21.
//

import Foundation

extension House {
    func toHouseListItem() -> HouseListItem {
        return HouseListItem(id: Int(identifier), name: name!, region: region!)
    }
}
