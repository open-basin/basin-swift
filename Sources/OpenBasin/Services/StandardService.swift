//
//  StandardService.swift
//  
//
//  Created by Nick Crews on 6/1/22.
//

import Foundation

struct StandardService {
    private let token: Int
    private let remote = RemoteService.shared

    init(token: Int) {
        self.token = token
    }

    func fetch(_ completion: @escaping (OBResult<StandardModel>) -> Void) {
        remote.fetch(StandardModel.self,
                     path: Path.Datastore.Standards.standard.rawValue,
                     queryItems: [
                        .init(name: "token", value: String(token))
                     ])
        { result in
            completion(result)
        }
    }

    func schema(_ completion: @escaping (OBResult<Data>) -> Void) {
        remote.fetch(path: Path.Datastore.Standards.schema.rawValue,
                     queryItems: [
                        .init(name: "token", value: String(token))
                     ])
        { result in
            completion(result)
        }
    }

    func data(_ completion: @escaping (OBResult<[DataModel]>) -> Void) {

        remote.fetch([DataModel].self,
                     path: Path.Datastore.Standards.data.rawValue,
                     queryItems: [
                        .init(name: "token", value: String(token))
                     ])
        { result in
            completion(result)
        }
    }

    func payloads(_ completion: @escaping (OBResult<Data>) -> Void) {
        remote.fetch(path: Path.Datastore.Standards.payloads.rawValue,
                     queryItems: [
                        .init(name: "token", value: String(token))
                     ])
        { result in
            completion(result)
        }
    }
}

struct StandardsService {
    private let tokens: Set<Int>
    private let remote = RemoteService.shared

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
    private let remote = RemoteService.shared

    struct AllStandards {
        func fetch(_ completion: @escaping (OBResult<[StandardModel]>) -> Void) {

        }

        func schemas(_ completion: @escaping (OBResult<[Data]>) -> Void) {

        }
    }
}
