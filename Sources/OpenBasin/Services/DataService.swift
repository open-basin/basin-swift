//
//  DataService.swift
//  
//
//  Created by Nick Crews on 6/1/22.
//

import Foundation

struct DataService: AsyncService {
    var thread: DispatchQueue?
    private let token: Int
    private let remote = RemoteService.shared

    init(token: Int,
         thread: DispatchQueue? = nil) {
        self.token = token
        self.thread = thread
    }

    func receive(on thread: DispatchQueue) -> Self {
        DataService(token: token, thread: thread)
    }

    func fetch(_ completion: @escaping (OBResult<DataModel>) -> Void) {

        remote.fetch(DataModel.self,
                     path: Path.Datastore.Data.data.rawValue,
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

    func payload(_ completion: @escaping (OBResult<Data>) -> Void) {
        
        remote.fetch(path: Path.Datastore.Data.payload.rawValue,
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

struct DatasService: AsyncService {
    var thread: DispatchQueue?
    private let tokens: Set<Int>
    private let remote = RemoteService.shared

    init(tokens: Set<Int>,
         thread: DispatchQueue? = nil) {
        self.tokens = tokens
        self.thread = thread
    }

    func receive(on thread: DispatchQueue) -> Self {
        DatasService(tokens: tokens, thread: thread)
    }

    func fetch(_ completion: @escaping (OBResult<[DataResponse]>) -> Void) {

    }

    func payloads(_ completion: @escaping (OBResult<[PayloadResponse]>) -> Void) {

    }


    struct DataResponse {
        let token: Int
        let data: DataModel
    }

    struct PayloadResponse {
        let token: Int
        let payload: Data
    }
}
