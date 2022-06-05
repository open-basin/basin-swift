//
//  DataDecoder.swift
//  
//
//  Created by Nick Crews on 6/5/22.
//

import Foundation

struct DataDecoder {

    static func decodeData(from decoder: Decoder, codingKey: CodingKey) throws -> Data {
        guard let options = decoder.userInfo[Options.key] as? Options else {
            throw OBErrorCases.invalidInput
        }

        let path = decoder.codingPath
        var item: Any? = options.json

        for key in path {
          if let intKey = key.intValue {
            item = (item as? [Any])?[intKey]
          } else {
            item = (item as? [String: Any])?[key.stringValue]
          }
        }

        guard let dict = item as? [String: Any],
              let model = dict[codingKey.stringValue] else {
            throw OBErrorCases.modelMismatch
        }

        return try JSONSerialization.data(withJSONObject: model)
    }

    static func decodeDataset(from decoder: Decoder, codingKey: CodingKey) throws -> [Data] {
        guard let options = decoder.userInfo[Options.key] as? Options else {
            throw OBErrorCases.invalidInput
        }

        let path = decoder.codingPath
        var item: Any? = options.json

        for key in path {
          if let intKey = key.intValue {
            item = (item as? [Any])?[intKey]
          } else {
            item = (item as? [String: Any])?[key.stringValue]
          }
        }

        guard let dict = item as? [String: Any],
              let models = dict[codingKey.stringValue] as? [Any] else {
            throw OBErrorCases.modelMismatch
        }

        var result = [Data]()
        for model in models {
            let data = try JSONSerialization.data(withJSONObject: model)
            result.append(data)
        }

        return result
    }

    struct Options {
        let json: Any

        static let key = CodingUserInfoKey(rawValue: "com.OpenBasin.DataCodingOptions")!
    }
}
