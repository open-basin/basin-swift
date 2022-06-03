//
//  StandardService.swift
//  
//
//  Created by Nick Crews on 6/1/22.
//

import Foundation

struct StandardService {
    private let token: Int

    init(token: Int) {
        self.token = token
    }

    func fetch(_ completion: @escaping (OBResult<StandardModel>) -> Void) {

    }

    func schema(_ completion: @escaping (OBResult<String>) -> Void) {

    }

    func data(_ completion: @escaping (OBResult<[DataModel]>) -> Void) {

    }

    func payloads(_ completion: @escaping (OBResult<[String]>) -> Void) {

    }
}

struct StandardsService {
    private let tokens: Set<Int>

    init(tokens: Set<Int>) {
        self.tokens = tokens
    }

    func fetch(_ completion: @escaping (OBResult<[Int: StandardModel]>) -> Void) {

    }

    func schemas(_ completion: @escaping (OBResult<[Int: String]>) -> Void) {

    }

    func data(_ completion: @escaping (OBResult<[Int: DataModel]>) -> Void) {

    }

    func payloads(_ completion: @escaping (OBResult<[Int: DataModel]>) -> Void) {

    }
}

struct AllStandardsService {

    let all = AllStandards()

    struct AllStandards {
        func fetch(_ completion: @escaping (OBResult<[StandardModel]>) -> Void) {

        }

        func schemas(_ completion: @escaping (OBResult<[String]>) -> Void) {

        }
    }
}
