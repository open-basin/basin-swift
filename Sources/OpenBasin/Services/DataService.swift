//
//  DataService.swift
//  
//
//  Created by Nick Crews on 6/1/22.
//

import Foundation

struct DataService {
    private let token: Int
    private let remote = RemoteService.shared

    init(token: Int) {
        self.token = token
    }

    func fetch(_ completion: @escaping (OBResult<DataModel>) -> Void) {

        remote.fetch(DataModel.self,
                     path: Path.Datastore.Data.data.rawValue,
                     queryItems: [
                        .init(name: "token", value: String(token))
                     ])
        { result in
            completion(result)
        }
    }

    func payload(_ completion: @escaping (OBResult<Data>) -> Void) {
        
        remote.fetch(path: Path.Datastore.Data.payload.rawValue,
                     queryItems: [
                        .init(name: "token", value: String(token))
                     ])
        { result in
            completion(result)
        }
    }
}

struct DatasService {
    private let tokens: Set<Int>
    private let remote = RemoteService.shared

    init(tokens: Set<Int>) {
        self.tokens = tokens
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
