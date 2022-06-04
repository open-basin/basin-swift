//
//  OwnerService.swift
//  
//
//  Created by Nick Crews on 6/2/22.
//

import Foundation

struct OwnerService: AsyncService {
    var thread: DispatchQueue?
    private let address: String
    private let remote = RemoteService.shared

    init(address: String,
         thread: DispatchQueue? = nil) {
        self.address = address
        self.thread = thread
    }

    func receive(on thread: DispatchQueue) -> Self {
        OwnerService(address: address, thread: thread)
    }

    func standard(_ token: Int) -> StandardOwnerService {
        StandardOwnerService(token: token, owner: address, thread: thread)
    }

    func standards(_ tokens: [Int]) -> StandardsOwnerService {
        StandardsOwnerService(tokens: tokens, owner: address, thread: thread)
    }

    func data(_ completion: @escaping (OBResult<[DataModel]>) -> Void) {

        remote.fetch([DataModel].self,
                     path: Path.Datastore.Owner.data.rawValue,
                     queryItems: [
                        .init(name: "address", value: address)
                     ])
        { result in
            if let thread = thread {
                thread.async {
                    completion(result)
                }
            } else {
                completion(result)
            }
        }
    }

    func payloads(_ completion: @escaping (OBResult<Data>) -> Void) {

        remote.fetch(path: Path.Datastore.Owner.payloads.rawValue,
                     queryItems: [
                        .init(name: "address", value: address)
                     ])
        { result in
            if let thread = thread {
                thread.async {
                    completion(result)
                }
            } else {
                completion(result)
            }
        }
    }
}

extension OwnerService {

    struct StandardOwnerService: AsyncService {
        var thread: DispatchQueue?
        private let token: Int
        private let owner: String
        private let remote = RemoteService.shared

        init(token: Int,
             owner: String,
             thread: DispatchQueue? = nil) {
            self.token = token
            self.owner = owner
            self.thread = thread
        }

        func receive(on thread: DispatchQueue) -> Self {
            StandardOwnerService(token: token, owner: owner, thread: thread)
        }

        func data(_ completion: @escaping (OBResult<[DataModel]>) -> Void) {

            remote.fetch([DataModel].self,
                         path: Path.Datastore.Owner.Standard.data.rawValue,
                         queryItems: [
                            .init(name: "address", value: owner),
                            .init(name: "standard", value: String(token))
                         ])
            { result in
                if let thread = thread {
                    thread.async {
                        completion(result)
                    }
                } else {
                    completion(result)
                }
            }
        }

        func payloads(_ completion: @escaping (OBResult<Data>) -> Void) {

            remote.fetch(path: Path.Datastore.Owner.Standard.payloads.rawValue,
                         queryItems: [
                            .init(name: "address", value: owner),
                            .init(name: "standard", value: String(token))
                         ])
            { result in
                if let thread = thread {
                    thread.async {
                        completion(result)
                    }
                } else {
                    completion(result)
                }
            }
        }
    }

    struct StandardsOwnerService: AsyncService {
        var thread: DispatchQueue?
        private let tokens: [Int]
        private let owner: String
        private let remote = RemoteService.shared

        init(tokens: [Int],
             owner: String,
             thread: DispatchQueue? = nil) {
            self.tokens = tokens
            self.owner = owner
            self.thread = thread
        }

        func receive(on thread: DispatchQueue) -> Self {
            StandardsOwnerService(tokens: tokens, owner: owner, thread: thread)
        }

        func data(_ completion: @escaping (OBResult<[DataResponse]>) -> Void) {

            remote.fetch([DataResponse].self,
                         path: Path.Datastore.Owner.Standard.standardsData.rawValue,
                         queryItems: [
                            .init(name: "address", value: owner),
                            .init(name: "standards", value: tokens.compactMap { String($0) }.joined(separator: ","))
                         ])
            { result in
                if let thread = thread {
                    thread.async {
                        completion(result)
                    }
                } else {
                    completion(result)
                }
            }
        }

        func payloads(_ completion: @escaping (OBResult<[PayloadsResponse]>) -> Void) {

            remote.fetch([PayloadsResponse].self,
                         path: Path.Datastore.Owner.Standard.standardsPayloads.rawValue,
                         queryItems: [
                            .init(name: "address", value: owner),
                            .init(name: "standards", value: tokens.compactMap { String($0) }.joined(separator: ","))
                         ])
            { result in
                if let thread = thread {
                    thread.async {
                        completion(result)
                    }
                } else {
                    completion(result)
                }
            }
        }

        struct DataResponse: DatastoreModel {
            let standardToken: Int
            let data: [DataModel]

            enum CodingKeys: String, CodingKey {
                case standardToken = "standard_token"
                case data
            }
        }

        struct PayloadsResponse: DatastoreModel {
            let standardToken: Int
            let payloads: [Data]

            enum CodingKeys: String, CodingKey {
                case standardToken = "standard_token"
                case payloads
            }
        }
    }
}

struct OwnersService: AsyncService {
    var thread: DispatchQueue?
    private let addresses: [String]
    private let remote = RemoteService.shared

    init(addresses: [String],
         thread: DispatchQueue? = nil) {
        self.addresses = addresses
        self.thread = thread
    }

    func receive(on thread: DispatchQueue) -> Self {
        OwnersService(addresses: addresses, thread: thread)
    }

    func standard(_ token: Int) -> StandardOwnersService {
        StandardOwnersService(token: token, owners: addresses, thread: thread)
    }

    func standards(_ tokens: [Int]) -> StandardsOwnersService {
        StandardsOwnersService(tokens: tokens, owners: addresses, thread: thread)
    }

    func data(_ completion: @escaping (OBResult<[DataResponse]>) -> Void) {

        remote.fetch([DataResponse].self,
                     path: Path.Datastore.Owners.data.rawValue,
                     queryItems: [
                        .init(name: "addresses", value: addresses.joined(separator: ","))
                     ])
        { result in
            if let thread = thread {
                thread.async {
                    completion(result)
                }
            } else {
                completion(result)
            }
        }
    }

    func payloads(_ completion: @escaping (OBResult<[PayloadsResponse]>) -> Void) {

        remote.fetch([PayloadsResponse].self,
                     path: Path.Datastore.Owners.payloads.rawValue,
                     queryItems: [
                        .init(name: "addresses", value: addresses.joined(separator: ","))
                     ])
        { result in
            if let thread = thread {
                thread.async {
                    completion(result)
                }
            } else {
                completion(result)
            }
        }
    }

    struct DataResponse: DatastoreModel {
        let owner: String
        let data: [DataModel]

        enum CodingKeys: String, CodingKey {
            case owner = "owner_address"
            case data
        }
    }

    struct PayloadsResponse: DatastoreModel {
        let owner: String
        let payloads: [Data]

        enum CodingKeys: String, CodingKey {
            case owner = "owner_address"
            case payloads
        }
    }
}

extension OwnersService {

    struct StandardOwnersService: AsyncService {
        var thread: DispatchQueue?
        private let token: Int
        private let owners: [String]
        private let remote = RemoteService.shared

        init(token: Int,
             owners: [String],
             thread: DispatchQueue? = nil) {
            self.token = token
            self.owners = owners
            self.thread = thread
        }

        func receive(on thread: DispatchQueue) -> Self {
            StandardOwnersService(token: token, owners: owners, thread: thread)
        }

        func data(_ completion: @escaping (OBResult<[DataResponse]>) -> Void) {

            remote.fetch([DataResponse].self,
                         path: Path.Datastore.Owners.Standard.data.rawValue,
                         queryItems: [
                            .init(name: "addresses", value: owners.joined(separator: ",")),
                            .init(name: "standard", value: String(token))
                         ])
            { result in
                if let thread = thread {
                    thread.async {
                        completion(result)
                    }
                } else {
                    completion(result)
                }
            }
        }

        func payloads(_ completion: @escaping (OBResult<[PayloadsResponse]>) -> Void) {

            remote.fetch([PayloadsResponse].self,
                         path: Path.Datastore.Owners.Standard.payloads.rawValue,
                         queryItems: [
                            .init(name: "addresses", value: owners.joined(separator: ",")),
                            .init(name: "standard", value: String(token))
                         ])
            { result in
                if let thread = thread {
                    thread.async {
                        completion(result)
                    }
                } else {
                    completion(result)
                }
            }
        }

        struct DataResponse: DatastoreModel {
            let owner: String
            let data: [DataModel]

            enum CodingKeys: String, CodingKey {
                case owner = "owner_address"
                case data
            }
        }

        struct PayloadsResponse: DatastoreModel {
            let owner: String
            let payloads: [Data]

            enum CodingKeys: String, CodingKey {
                case owner = "owner_address"
                case payloads
            }
        }
    }

    struct StandardsOwnersService: AsyncService {
        var thread: DispatchQueue?
        private let tokens: [Int]
        private let owners: [String]
        private let remote = RemoteService.shared
        
        init(tokens: [Int],
             owners: [String],
             thread: DispatchQueue? = nil) {
            self.tokens = tokens
            self.owners = owners
            self.thread = thread
        }

        func receive(on thread: DispatchQueue) -> Self {
            StandardsOwnersService(tokens: tokens, owners: owners, thread: thread)
        }

        func data(_ completion: @escaping (OBResult<[DataOwnerResponse]>) -> Void) {

            remote.fetch([DataOwnerResponse].self,
                         path: Path.Datastore.Owners.Standard.standardsData.rawValue,
                         queryItems: [
                            .init(name: "addresses", value: owners.joined(separator: ",")),
                            .init(name: "standards", value: tokens.compactMap { String($0) }.joined(separator: ","))
                         ])
            { result in
                if let thread = thread {
                    thread.async {
                        completion(result)
                    }
                } else {
                    completion(result)
                }
            }
        }

        func payloads(_ completion: @escaping (OBResult<[PayloadsOwnerResponse]>) -> Void) {

            remote.fetch([PayloadsOwnerResponse].self,
                         path: Path.Datastore.Owners.Standard.standardsPayloads.rawValue,
                         queryItems: [
                            .init(name: "addresses", value: owners.joined(separator: ",")),
                            .init(name: "standards", value: tokens.compactMap { String($0) }.joined(separator: ","))
                         ])
            { result in
                if let thread = thread {
                    thread.async {
                        completion(result)
                    }
                } else {
                    completion(result)
                }
            }
        }

        struct DataOwnerResponse: DatastoreModel {
            let owner: String
            let standardToken: Int
            let data: [DataModel]

            enum CodingKeys: String, CodingKey {
                case owner = "owner_address"
                case standardToken = "standard_token"
                case data
            }
        }

        struct PayloadsOwnerResponse: DatastoreModel {
            let owner: String
            let standardToken: Int
            let payloads: [Data]

            enum CodingKeys: String, CodingKey {
                case owner = "owner_address"
                case standardToken = "standard_token"
                case payloads
            }
        }
    }
}
