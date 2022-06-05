//
//  ResponseModels.swift
//  
//
//  Created by Nick Crews on 6/5/22.
//

import Foundation

public struct DataSelfModel: DatastoreModel {
    public let dataToken: Int
    public let data: DataModel

    enum CodingKeys: String, CodingKey {
        case dataToken = "data_token"
        case data
    }
}

public struct DataPayloadModel: DatastoreModel {
    public let dataToken: Int
    public let payload: Data

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
    public let standardToken: Int
    public let standard: StandardModel

    enum CodingKeys: String, CodingKey {
        case standardToken = "standard_token"
        case standard
    }
}

public struct StandardSchemaModel: DatastoreModel {
    public let standardToken: Int
    public let schema: Data

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
    public let standardToken: Int
    public let data: [DataModel]

    enum CodingKeys: String, CodingKey {
        case standardToken = "standard_token"
        case data
    }
}

public struct StandardPayloadsModel: DatastoreModel {
    public let standardToken: Int
    public let payloads: [Data]

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
    public let owner: String
    public let data: [DataModel]

    enum CodingKeys: String, CodingKey {
        case owner = "owner_address"
        case data
    }
}

public struct OwnerPayloadsModel: DatastoreModel {
    public let owner: String
    public let payloads: [Data]

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
    public let owner: String
    public let standardToken: Int
    public let data: [DataModel]

    enum CodingKeys: String, CodingKey {
        case owner = "owner_address"
        case standardToken = "standard_token"
        case data
    }
}

public struct OwnerStandardPayloadsModel: DatastoreModel {
    public let owner: String
    public let standardToken: Int
    public let payloads: [Data]

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
