//
//  OwnerService.swift
//  
//
//  Created by Nick Crews on 6/2/22.
//

import Foundation

struct OwnerService {
    private let address: String

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

    }

    func payloads(_ completion: @escaping (OBResult<[String]>) -> Void) {

    }
}

extension OwnerService {

    struct StandardOwnerService {
        private let token: Int
        private let owner: String

        init(token: Int,
             owner: String) {
            self.token = token
            self.owner = owner
        }

        func data(_ completion: @escaping (OBResult<[DataModel]>) -> Void) {

        }

        func payloads(_ completion: @escaping (OBResult<[String]>) -> Void) {

        }
    }

    struct StandardsOwnerService {
        private let tokens: Set<Int>
        private let owner: String

        init(tokens: Set<Int>,
             owner: String) {
            self.tokens = tokens
            self.owner = owner
        }

        func data(_ completion: @escaping (OBResult<[Int: DataModel]>) -> Void) {

        }

        func payloads(_ completion: @escaping (OBResult<[Int: String]>) -> Void) {

        }
    }
}

struct OwnersService {
    private let addresses: Set<String>

    init(addresses: Set<String>) {
        self.addresses = addresses
    }

    func standard(_ token: Int) -> StandardOwnersService {
        StandardOwnersService(token: token, owners: addresses)
    }

    func standards(_ tokens: Set<Int>) -> StandardsOwnersService {
        StandardsOwnersService(tokens: tokens, owners: addresses)
    }

    func data(_ completion: @escaping (OBResult<[String: DataModel]>) -> Void) {

    }

    func payloads(_ completion: @escaping (OBResult<[String: String]>) -> Void) {

    }
}

extension OwnersService {

    struct StandardOwnersService {
        private let token: Int
        private let owners: Set<String>

        init(token: Int,
             owners: Set<String>) {
            self.token = token
            self.owners = owners
        }

        func data(_ completion: @escaping (OBResult<[DataModel]>) -> Void) {

        }

        func payloads(_ completion: @escaping (OBResult<[String]>) -> Void) {

        }
    }

    struct StandardsOwnersService {
        private let tokens: Set<Int>
        private let owners: Set<String>

        init(tokens: Set<Int>,
             owners: Set<String>) {
            self.tokens = tokens
            self.owners = owners
        }

        func data(_ completion: @escaping (OBResult<[String: [Int: DataModel]]>) -> Void) {

        }

        func payloads(_ completion: @escaping (OBResult<[String: [Int: String]]>) -> Void) {

        }
    }
}
