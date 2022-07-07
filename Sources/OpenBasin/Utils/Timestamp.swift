//
//  Timestamp.swift
//  
//
//  Created by Nick Crews on 7/6/22.
//

import Foundation

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
