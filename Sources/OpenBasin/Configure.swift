//
//  Configure.swift
//  
//
//  Created by Nick Crews on 6/1/22.
//

import Foundation

public func configure(with configuration: Configuration) {
    Environment.shared = configuration.environment()
}

public enum Configuration {
    case goerli(key: String)
    case mainnet(key: String)

    func environment() -> Environment {
        switch self {
        case .goerli(let key):
            return Environment(chain: .goerli,
                               apiKey: key)
        case .mainnet(let key):
            return Environment(chain: .mainnet,
                               apiKey: key)
        }
    }
}
