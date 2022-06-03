//
//  StandardModel.swift
//  
//
//  Created by Nick Crews on 6/1/22.
//

import Foundation

struct StandardModel: DatastoreModel {
    let token: Int
    let minter: String
    let name: Int
    let schema: Data
}
