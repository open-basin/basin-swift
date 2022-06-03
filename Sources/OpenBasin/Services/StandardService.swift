//
//  StandardService.swift
//  
//
//  Created by Nick Crews on 6/1/22.
//

import Foundation

struct StandardService: AsyncService {
    var thread: DispatchQueue?
    private let token: Int
    private let remote = RemoteService.shared

    init(token: Int,
         thread: DispatchQueue? = nil) {
        self.token = token
        self.thread = thread
    }

    func receive(on thread: DispatchQueue) -> Self {
        StandardService(token: token, thread: thread)
    }

    func fetch(_ completion: @escaping (OBResult<StandardModel>) -> Void) {
        remote.fetch(StandardModel.self,
                     path: Path.Datastore.Standards.standard.rawValue,
                     queryItems: [
                        .init(name: "token", value: String(token))
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

    func schema(_ completion: @escaping (OBResult<Data>) -> Void) {
        remote.fetch(path: Path.Datastore.Standards.schema.rawValue,
                     queryItems: [
                        .init(name: "token", value: String(token))
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

    func data(_ completion: @escaping (OBResult<[DataModel]>) -> Void) {

        remote.fetch([DataModel].self,
                     path: Path.Datastore.Standards.data.rawValue,
                     queryItems: [
                        .init(name: "token", value: String(token))
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
        remote.fetch(path: Path.Datastore.Standards.payloads.rawValue,
                     queryItems: [
                        .init(name: "token", value: String(token))
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

struct StandardsService: AsyncService {
    var thread: DispatchQueue?
    private let tokens: Set<Int>
    private let remote = RemoteService.shared

    init(tokens: Set<Int>,
         thread: DispatchQueue? = nil) {
        self.tokens = tokens
        self.thread = thread
    }

    func receive(on thread: DispatchQueue) -> Self {
        StandardsService(tokens: tokens, thread: thread)
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

struct AllStandardsService: AsyncService {
    let thread: DispatchQueue?
    private let remote = RemoteService.shared

    var all: AllStandards {
        AllStandards(thread: self.thread)
    }

    init(thread: DispatchQueue? = nil) {
        self.thread = thread
    }

    func receive(on thread: DispatchQueue) -> Self {
        AllStandardsService(thread: thread)
    }

    struct AllStandards: AsyncService {
        let thread: DispatchQueue?
        private let remote = RemoteService.shared

        init(thread: DispatchQueue? = nil) {
            self.thread = thread
        }

        func receive(on thread: DispatchQueue) -> Self {
            AllStandards(thread: thread)
        }

        func fetch(_ completion: @escaping (OBResult<[StandardModel]>) -> Void) {

        }

        func schemas(_ completion: @escaping (OBResult<[Data]>) -> Void) {

        }
    }
}
