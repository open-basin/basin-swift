//
//  OBERROR.swift
//  
//
//  Created by Nick Crews on 6/1/22.
//

import Foundation

public struct OBError: Equatable {
    let code: Int
    let message: String
}

public enum OBErrorCases: Error {
    case badResponse
    case invalidInput
    case modelMismatch

    func obj() -> OBError {
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

public struct ErrorConstants {

    static let badResponse = OBError(code: 400, message: "Bad Response.")

    static let invalidInput = OBError(code: 410, message: "Invalid Input.")

    static let modelMismatch = OBError(code: 420, message: "Model Mismatch.")
}

public enum ResultError {
    case badResponse
    case invalidInput
    case modelMismatch
}

extension ResultError: RawRepresentable {
    public typealias RawValue = OBError

    public init?(rawValue: RawValue) {
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

    public var rawValue: RawValue {
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
