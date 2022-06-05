//
//  DataService.swift
//  
//
//  Created by Nick Crews on 6/1/22.
//

import Foundation

public struct DataService: AsyncService {
    var thread: DispatchQueue?
    private let token: Int
    private let remote = RemoteService.shared

    init(token: Int,
         thread: DispatchQueue? = nil) {
        self.token = token
        self.thread = thread
    }

    public func receive(on thread: DispatchQueue) -> Self {
        DataService(token: token, thread: thread)
    }

    public func fetch(_ completion: @escaping (OBResult<DataModel>) -> Void) {

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

    public func payload(_ completion: @escaping (OBResult<Data>) -> Void) {
        
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

public struct DatasService: AsyncService {
    var thread: DispatchQueue?
    private let tokens: [Int]
    private let remote = RemoteService.shared

    init(tokens: [Int],
         thread: DispatchQueue? = nil) {
        self.tokens = tokens
        self.thread = thread
    }

    public func receive(on thread: DispatchQueue) -> Self {
        DatasService(tokens: tokens, thread: thread)
    }

    public func fetch(_ completion: @escaping (OBResult<[DataSelfModel]>) -> Void) {
        
        remote.fetch([DataSelfModel].self,
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

    public func payloads(_ completion: @escaping (OBResult<[DataPayloadModel]>) -> Void) {

        remote.fetch([DataPayloadModel].self,
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
}
