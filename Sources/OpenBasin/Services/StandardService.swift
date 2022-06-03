//
//  StandardService.swift
//  
//
//  Created by Nick Crews on 6/1/22.
//

import Foundation

struct StandardService {
    private let token: Int
    private let remote = RemoteService()

    init(token: Int) {
        self.token = token
    }

    func fetch(_ completion: @escaping (OBResult<StandardModel>) -> Void) {

    }

    func schema(_ completion: @escaping (OBResult<Data>) -> Void) {

    }

    func data(_ completion: @escaping (OBResult<[DataModel]>) -> Void) {

    }

    func payloads(_ completion: @escaping (OBResult<[Data]>) -> Void) {

    }
}

struct StandardsService {
    private let tokens: Set<Int>

    init(tokens: Set<Int>) {
        self.tokens = tokens
    }

    func fetch(_ completion: @escaping (OBResult<[StandardResponse]>) -> Void) {

    }

    func schemas(_ completion: @escaping (OBResult<[SchemaResponse]>) -> Void) {

    }

    func data(_ completion: @escaping (OBResult<[DataResponse]>) -> Void) {

    }

    func payloads(_ completion: @escaping (OBResult<[PayloadResponse]>) -> Void) {

    }

    struct StandardResponse {
        let standard: Int
        let Standard: StandardModel
    }

    struct SchemaResponse {
        let standard: Int
        let schema: Data
    }

    struct DataResponse {
        let standard: Int
        let data: DataModel
    }

    struct PayloadResponse {
        let standard: Int
        let payload: Data
    }
}

struct AllStandardsService {

    let all = AllStandards()

    struct AllStandards {
        func fetch(_ completion: @escaping (OBResult<[StandardModel]>) -> Void) {

        }

        func schemas(_ completion: @escaping (OBResult<[Data]>) -> Void) {

        }
    }
}
