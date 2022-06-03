//
//  API.swift
//  
//
//  Created by Nick Crews on 6/1/22.
//

import Foundation

public struct Datastore {
    typealias api = Services
}

struct Services {

    static func owner(_ address: String) -> OwnerService {
        OwnerService(address: address)
    }

    static func owners(_ addresses: Set<String>) -> OwnersService {
        OwnersService(addresses: addresses)
    }

    static func data(_ tokens: Set<Int>) -> DatasService {
        DatasService(tokens: tokens)
    }

    static func data(_ token: Int) -> DataService {
        DataService(token: token)
    }

    static func standards(_ tokens: Set<Int>) -> StandardsService {
        StandardsService(tokens: tokens)
    }

    static func standard(_ token: Int) -> StandardService {
        StandardService(token: token)
    }

    static func provider(_ address: String) -> ProviderService {
        ProviderService(address: address)
    }

    static func minter(_ address: String) -> MinterService {
        MinterService(address: address)
    }

    static let standards = AllStandardsService()
}
