//
//  Provider.swift
//  
//
//  Created by Nick Crews on 6/2/22.
//

import Foundation

struct ProviderService: AsyncService {
    var thread: DispatchQueue?
    private let address: String
    private let remote = RemoteService.shared

    init(address: String,
         thread: DispatchQueue? = nil) {
        self.address = address
        self.thread = thread
    }

    func receive(on thread: DispatchQueue) -> Self {
        ProviderService(address: address, thread: thread)
    }

    func data(_ completion: @escaping (OBResult<[DataModel]>) -> Void) {

        remote.fetch([DataModel].self,
                     path: Path.Datastore.Provider.data.rawValue,
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

    func payloads(_ completion: @escaping (OBResult<Data>) -> Void) {

        remote.fetch(path: Path.Datastore.Provider.payloads.rawValue,
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
