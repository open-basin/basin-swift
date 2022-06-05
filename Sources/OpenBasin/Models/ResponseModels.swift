//
//  ResponseModels.swift
//  
//
//  Created by Nick Crews on 6/5/22.
//

import Foundation

public struct DataSelfModel: DatastoreModel {
    let dataToken: Int
    let data: DataModel

    enum CodingKeys: String, CodingKey {
        case dataToken = "data_token"
        case data
    }
}

public struct DataPayloadModel: DatastoreModel {
    let dataToken: Int
    let payload: Data

    enum CodingKeys: String, CodingKey {
        case dataToken = "data_token"
        case payload
    }

    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        dataToken = try values.decode(Int.self, forKey: .dataToken)
        payload = try DataDecoder.decodeData(from: decoder, codingKey: CodingKeys.payload)
    }
}

public struct StandardSelfModel: DatastoreModel {
    let standardToken: Int
    let standard: StandardModel

    enum CodingKeys: String, CodingKey {
        case standardToken = "standard_token"
        case standard
    }
}

public struct StandardSchemaModel: DatastoreModel {
    let standardToken: Int
    let schema: Data

    enum CodingKeys: String, CodingKey {
        case standardToken = "standard_token"
        case schema
    }

    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        standardToken = try values.decode(Int.self, forKey: .standardToken)
        schema = try DataDecoder.decodeData(from: decoder, codingKey: CodingKeys.schema)
    }
}

public struct StandardDataModel: DatastoreModel {
    let standardToken: Int
    let data: [DataModel]

    enum CodingKeys: String, CodingKey {
        case standardToken = "standard_token"
        case data
    }
}

public struct StandardPayloadsModel: DatastoreModel {
    let standardToken: Int
    let payloads: [Data]

    enum CodingKeys: String, CodingKey {
        case standardToken = "standard_token"
        case payloads
    }

    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        standardToken = try values.decode(Int.self, forKey: .standardToken)
        payloads = try DataDecoder.decodeDataset(from: decoder, codingKey: CodingKeys.payloads)
    }
}

public struct OwnerDataModel: DatastoreModel {
    let owner: String
    let data: [DataModel]

    enum CodingKeys: String, CodingKey {
        case owner = "owner_address"
        case data
    }
}

public struct OwnerPayloadsModel: DatastoreModel {
    let owner: String
    let payloads: [Data]

    enum CodingKeys: String, CodingKey {
        case owner = "owner_address"
        case payloads
    }

    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        owner = try values.decode(String.self, forKey: .owner)
        payloads = try DataDecoder.decodeDataset(from: decoder, codingKey: CodingKeys.payloads)
    }
}

public struct OwnerStandardDataModel: DatastoreModel {
    let owner: String
    let standardToken: Int
    let data: [DataModel]

    enum CodingKeys: String, CodingKey {
        case owner = "owner_address"
        case standardToken = "standard_token"
        case data
    }
}

public struct OwnerStandardPayloadsModel: DatastoreModel {
    let owner: String
    let standardToken: Int
    let payloads: [Data]

    enum CodingKeys: String, CodingKey {
        case owner = "owner_address"
        case standardToken = "standard_token"
        case payloads
    }

    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        owner = try values.decode(String.self, forKey: .owner)
        standardToken = try values.decode(Int.self, forKey: .standardToken)
        payloads = try DataDecoder.decodeDataset(from: decoder, codingKey: CodingKeys.payloads)
    }
}
