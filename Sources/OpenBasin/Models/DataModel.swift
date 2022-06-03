//
//  DataModel.swift
//  
//
//  Created by Nick Crews on 6/1/22.
//

import Foundation

struct DataModel: Codable {
    let token: Int
    let owner: String
    let provider: String
    let standard: Int
    let timestamp: Date
    let payload: String
}