//
//  MinterService.swift
//  
//
//  Created by Nick Crews on 6/2/22.
//

import Foundation

struct MinterService {
    private let address: String
    private let remote = RemoteService.shared

    init(address: String) {
        self.address = address
    }

    func standards(_ completion: @escaping (OBResult<[StandardModel]>) -> Void) {

        remote.fetch([StandardModel].self,
                     path: Path.Datastore.Minter.standards.rawValue,
                     queryItems: [
                        .init(name: "address", value: address)
                     ])
        { result in
            completion(result)
        }
    }

    func schemas(_ completion: @escaping (OBResult<Data>) -> Void) {

        remote.fetch(path: Path.Datastore.Data.data.rawValue,
                     queryItems: [
                        .init(name: "address", value: address)
                     ])
        { result in
            completion(result)
        }
    }
}
