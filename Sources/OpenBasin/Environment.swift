//
//  Environment.swift
//  
//
//  Created by Nick Crews on 6/1/22.
//

import Foundation

struct Environment {
    static var shared: Environment?

    let chain: Chain
    let apiKey: String

    var bearerToken: String {
        return "Bearer " + apiKey
    }
}

enum Chain {
    case goerli
    case mainnet

    var engine: String {
        switch self {
        case .goerli:
            return "api.goerli.openbasin.io"
        case .mainnet:
            return "api.openbasin.io"
        }
    }
}
