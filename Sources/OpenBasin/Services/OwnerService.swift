//
//  OwnerService.swift
//  
//
//  Created by Nick Crews on 6/2/22.
//

import Foundation

struct OwnerService {
    private let address: String
    private let remote = RemoteService.shared

    init(address: String) {
        self.address = address
    }

    func standard(_ token: Int) -> StandardOwnerService {
        StandardOwnerService(token: token, owner: address)
    }

    func standards(_ tokens: Set<Int>) -> StandardsOwnerService {
        StandardsOwnerService(tokens: tokens, owner: address)
    }

    func data(_ completion: @escaping (OBResult<[DataModel]>) -> Void) {

        remote.fetch([DataModel].self,
                     path: Path.Datastore.Owner.data.rawValue,
                     queryItems: [
                        .init(name: "address", value: address)
                     ])
        { result in
            completion(result)
        }
    }

    func payloads(_ completion: @escaping (OBResult<Data>) -> Void) {

        remote.fetch(path: Path.Datastore.Owner.payloads.rawValue,
                     queryItems: [
                        .init(name: "address", value: address)
                     ])
        { result in
            completion(result)
        }
    }
}

extension OwnerService {

    struct StandardOwnerService {
        private let token: Int
        private let owner: String
        private let remote = RemoteService.shared

        init(token: Int,
             owner: String) {
            self.token = token
            self.owner = owner
        }

        func data(_ completion: @escaping (OBResult<[DataModel]>) -> Void) {

            remote.fetch([DataModel].self,
                         path: Path.Datastore.Owner.Standard.data.rawValue,
                         queryItems: [
                            .init(name: "address", value: owner),
                            .init(name: "standard", value: String(token))
                         ])
            { result in
                completion(result)
            }
        }

        func payloads(_ completion: @escaping (OBResult<Data>) -> Void) {

            remote.fetch(path: Path.Datastore.Owner.Standard.payloads.rawValue,
                         queryItems: [
                            .init(name: "address", value: owner),
                            .init(name: "standard", value: String(token))
                         ])
            { result in
                completion(result)
            }
        }
    }

    struct StandardsOwnerService {
        private let tokens: Set<Int>
        private let owner: String
        private let remote = RemoteService.shared

        init(tokens: Set<Int>,
             owner: String) {
            self.tokens = tokens
            self.owner = owner
        }

        func data(_ completion: @escaping (OBResult<[DataResponse]>) -> Void) {

        }

        func payloads(_ completion: @escaping (OBResult<[PayloadsResponse]>) -> Void) {

        }

        struct DataResponse {
            let standard: Int
            let data: DataModel
        }

        struct PayloadsResponse {
            let standard: Int
            let payload: Data
        }
    }
}

struct OwnersService {
    private let addresses: Set<String>
    private let remote = RemoteService.shared

    init(addresses: Set<String>) {
        self.addresses = addresses
    }

    func standard(_ token: Int) -> StandardOwnersService {
        StandardOwnersService(token: token, owners: addresses)
    }

    func standards(_ tokens: Set<Int>) -> StandardsOwnersService {
        StandardsOwnersService(tokens: tokens, owners: addresses)
    }

    func data(_ completion: @escaping (OBResult<[DataResponse]>) -> Void) {

    }

    func payloads(_ completion: @escaping (OBResult<[PayloadsResponse]>) -> Void) {

    }

    struct DataResponse {
        let address: String
        let data: DataModel
    }

    struct PayloadsResponse {
        let address: String
        let payload: Data
    }
}

extension OwnersService {

    struct StandardOwnersService {
        private let token: Int
        private let owners: Set<String>
        private let remote = RemoteService.shared

        init(token: Int,
             owners: Set<String>) {
            self.token = token
            self.owners = owners
        }

        func data(_ completion: @escaping (OBResult<[DataModel]>) -> Void) {

        }

        func payloads(_ completion: @escaping (OBResult<Data>) -> Void) {

        }
    }

    struct StandardsOwnersService {
        private let tokens: Set<Int>
        private let owners: Set<String>
        private let remote = RemoteService.shared
        
        init(tokens: Set<Int>,
             owners: Set<String>) {
            self.tokens = tokens
            self.owners = owners
        }

        func data(_ completion: @escaping (OBResult<[DataOwnerResponse]>) -> Void) {

        }

        func payloads(_ completion: @escaping (OBResult<[PayloadsOwnerResponse]>) -> Void) {

        }

        struct DataOwnerResponse {
            let owner: String
            let standard: Int
            let data: DataModel
        }

        struct PayloadsOwnerResponse {
            let owner: String
            let standard: Int
            let payload: Data
        }
    }
}
