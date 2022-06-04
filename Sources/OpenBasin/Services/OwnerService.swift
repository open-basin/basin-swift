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

        func data(_ completion: @escaping (OBResult<[DataModel]>) -> Void) {

        }

        func payloads(_ completion: @escaping (OBResult<Data>) -> Void) {

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
