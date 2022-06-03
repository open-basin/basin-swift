//
//  OBERROR.swift
//  
//
//  Created by Nick Crews on 6/1/22.
//

import Foundation

struct OBError: Equatable {
    let code: Int
    let message: String
}

enum OBErrorCases: Error {
    case badResponse
}

struct ErrorConstants {

    static let badResponse = OBError(code: 400, message: "Bad Response.")

    static let invalidInput = OBError(code: 410, message: "Invalid Input.")

    static let modelMismatch = OBError(code: 420, message: "Model Mismatch.")
}

enum ResultError {
    case badResponse
    case invalidInput
    case modelMismatch
}

extension ResultError: RawRepresentable {
    typealias RawValue = OBError

    init?(rawValue: RawValue) {
        switch rawValue {
        case ErrorConstants.badResponse:
            self = .badResponse
        case ErrorConstants.invalidInput:
            self = .invalidInput
        case ErrorConstants.modelMismatch:
            self = .modelMismatch
        default: return nil
        }
    }

    var rawValue: RawValue {
        switch self {
        case .badResponse:
            return ErrorConstants.badResponse
        case .invalidInput:
            return ErrorConstants.invalidInput
        case .modelMismatch:
            return ErrorConstants.modelMismatch
        }
    }
}
