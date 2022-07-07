//
//  StandardModel.swift
//  
//
//  Created by Nick Crews on 6/1/22.
//

import Foundation

public struct StandardModel: DatastoreModel {
    public let token: Int
    public let minter: String
    public let name: String
    public let schemaHash: String
    public let schema: Data

    enum CodingKeys: String, CodingKey {
        case token
        case minter
        case name
        case schemaHash = "schema_hash"
        case schema
    }

    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        token = try values.decode(Int.self, forKey: .token)
        minter = try values.decode(String.self, forKey: .minter)
        name = try values.decode(String.self, forKey: .name)
        schemaHash = try values.decode(String.self, forKey: .schemaHash)
        schema = try DataDecoder.decodeData(from: decoder, codingKey: CodingKeys.schema)
    }
}
