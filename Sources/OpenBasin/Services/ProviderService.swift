//
//  Provider.swift
//  
//
//  Created by Nick Crews on 6/2/22.
//

import Foundation

struct ProviderService {
    private let address: String
    private let remote = RemoteService.shared

    init(address: String) {
        self.address = address
    }

    func data(_ completion: @escaping (OBResult<[DataModel]>) -> Void) {

        remote.fetch([DataModel].self,
                     path: Path.Datastore.Provider.data.rawValue,
                     queryItems: [
                        .init(name: "address", value: address)
                     ])
        { result in
            completion(result)
        }
    }

    func payloads(_ completion: @escaping (OBResult<Data>) -> Void) {

        remote.fetch(path: Path.Datastore.Provider.payloads.rawValue,
                     queryItems: [
                        .init(name: "address", value: address)
                     ])
        { result in
            completion(result)
        }

    }
}
