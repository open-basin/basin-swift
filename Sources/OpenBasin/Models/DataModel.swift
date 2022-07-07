//
//  DataModel.swift
//  
//
//  Created by Nick Crews on 6/1/22.
//

import Foundation

public struct DataModel: DatastoreModel {
    public let token: Int
    public let owner: String
    public let provider: String
    public let standard: Int
    public let timestamp: Date
    public let payloadHash: String
    public let payload: Data

    enum CodingKeys: String, CodingKey {
        case token
        case owner
        case provider
        case standard
        case timestamp
        case payloadHash = "payload_hash"
        case payload
    }

    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        token = try values.decode(Int.self, forKey: .token)
        owner = try values.decode(String.self, forKey: .owner)
        provider = try values.decode(String.self, forKey: .provider)
        standard = try values.decode(Int.self, forKey: .standard)
        payloadHash = try values.decode(String.self, forKey: CodingKeys.payloadHash)

        let dateString = try values.decode(String.self, forKey: .timestamp)
        timestamp = try TimestampFactory.shared.date(from: dateString)

        payload = try DataDecoder.decodeData(from: decoder, codingKey: CodingKeys.payload)
    }
}
