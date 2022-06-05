//
//  DataModel.swift
//  
//
//  Created by Nick Crews on 6/1/22.
//

import Foundation

public struct DataModel: DatastoreModel {
    let token: Int
    let owner: String
    let provider: String
    let standard: Int
    let timestamp: Date
    let payload: Data

    enum CodingKeys: String, CodingKey {
        case token
        case owner
        case provider
        case standard
        case timestamp
        case payload
    }

    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        token = try values.decode(Int.self, forKey: .token)
        owner = try values.decode(String.self, forKey: .owner)
        provider = try values.decode(String.self, forKey: .provider)
        standard = try values.decode(Int.self, forKey: .standard)

        let dateString = try values.decode(String.self, forKey: .timestamp)
        timestamp = try TimestampFactory.shared.date(from: dateString)

        payload = try DataDecoder.decodeData(from: decoder, codingKey: CodingKeys.payload)
    }
}

struct TimestampFactory {

    static let shared = TimestampFactory()

    var standardFormatter: DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"

        return dateFormatter
    }

    func date(from str: String) throws -> Date {
        guard let date = standardFormatter.date(from: str) else {
            throw OBErrorCases.modelMismatch
        }

        return date
    }
}
