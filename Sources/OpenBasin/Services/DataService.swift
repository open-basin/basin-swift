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
    private let tokens: [Int]
    private let remote = RemoteService.shared

    init(tokens: [Int],
         thread: DispatchQueue? = nil) {
        self.tokens = tokens
        self.thread = thread
    }

    func receive(on thread: DispatchQueue) -> Self {
        DatasService(tokens: tokens, thread: thread)
    }

    func fetch(_ completion: @escaping (OBResult<[DataResponse]>) -> Void) {
        
        remote.fetch([DataResponse].self,
                     path: Path.Datastore.Data.dataset.rawValue,
                     queryItems: [
                        .init(name: "tokens", value: tokens.compactMap { String($0) } .joined(separator: ","))
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

    func payloads(_ completion: @escaping (OBResult<[PayloadResponse]>) -> Void) {

        remote.fetch([PayloadResponse].self,
                     path: Path.Datastore.Data.payloads.rawValue,
                     queryItems: [
                        .init(name: "tokens", value: tokens.compactMap { String($0) } .joined(separator: ","))
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
        let dataToken: Int
        let data: DataModel

        enum CodingKeys: String, CodingKey {
            case dataToken = "data_token"
            case data
        }
    }

    struct PayloadResponse: DatastoreModel {
        let dataToken: Int
        let payload: Data

        enum CodingKeys: String, CodingKey {
            case dataToken = "data_token"
            case payload
        }
    }
}
