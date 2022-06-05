//
//  API.swift
//  
//
//  Created by Nick Crews on 6/1/22.
//

import Foundation

public struct Datastore {
    public typealias api = Services
}

public struct Services {

    public static func owner(_ address: String) -> OwnerService {
        OwnerService(address: address)
    }

    public static func owners(_ addresses: [String]) -> OwnersService {
        OwnersService(addresses: addresses)
    }

    public static func data(_ tokens: [Int]) -> DatasService {
        DatasService(tokens: tokens)
    }

    public static func data(_ token: Int) -> DataService {
        DataService(token: token)
    }

    public static func standards(_ tokens: [Int]) -> StandardsService {
        StandardsService(tokens: tokens)
    }

    public static func standard(_ token: Int) -> StandardService {
        StandardService(token: token)
    }

    public static func provider(_ address: String) -> ProviderService {
        ProviderService(address: address)
    }

    public static func minter(_ address: String) -> MinterService {
        MinterService(address: address)
    }

    public static let standards = AllStandardsService()
}
