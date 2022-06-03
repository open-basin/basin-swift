//
//  MinterService.swift
//  
//
//  Created by Nick Crews on 6/2/22.
//

import Foundation

struct MinterService: AsyncService {
    var thread: DispatchQueue?
    private let address: String
    private let remote = RemoteService.shared

    init(address: String,
         thread: DispatchQueue? = nil) {
        self.address = address
    }

    func receive(on thread: DispatchQueue) -> Self {
        MinterService(address: address, thread: thread)
    }

    func standards(_ completion: @escaping (OBResult<[StandardModel]>) -> Void) {

        remote.fetch([StandardModel].self,
                     path: Path.Datastore.Minter.standards.rawValue,
                     queryItems: [
                        .init(name: "address", value: address)
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

    func schemas(_ completion: @escaping (OBResult<Data>) -> Void) {

        remote.fetch(path: Path.Datastore.Data.data.rawValue,
                     queryItems: [
                        .init(name: "address", value: address)
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
