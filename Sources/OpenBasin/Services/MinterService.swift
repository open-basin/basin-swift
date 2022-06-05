//
//  MinterService.swift
//  
//
//  Created by Nick Crews on 6/2/22.
//

import Foundation

public struct MinterService: AsyncService {
    var thread: DispatchQueue?
    private let address: String
    private let remote = RemoteService.shared

    init(address: String,
         thread: DispatchQueue? = nil) {
        self.address = address
        self.thread = thread
    }

    public func receive(on thread: DispatchQueue) -> Self {
        MinterService(address: address, thread: thread)
    }

    public func standards(_ completion: @escaping (OBResult<[StandardModel]>) -> Void) {

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

    public func schemas(_ completion: @escaping (OBResult<[Data]>) -> Void) {

        remote.fetchSet(path: Path.Datastore.Data.data.rawValue,
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
