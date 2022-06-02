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
    case rinkeby(key: String)
    case mainnet(key: String)

    func environment() -> Environment {
        switch self {
        case .rinkeby(let key):
            return Environment(chain: .rinkeby,
                               appEngine: AppEngine.rinkeby,
                               apiKey: key)
        case .mainnet(let key):
            return Environment(chain: .mainnet,
                               appEngine: AppEngine.mainnet,
                               apiKey: key)
        }
    }
}
