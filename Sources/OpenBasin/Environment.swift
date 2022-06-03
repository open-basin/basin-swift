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
    let appEngine: AppEngine
    let apiKey: String
}

enum Chain {
    case rinkeby
    case mainnet
}

enum AppEngine: String {
    case rinkeby = "api.rinkeby.openbasin.io"
    case mainnet = "api.openbasin.io"
}
