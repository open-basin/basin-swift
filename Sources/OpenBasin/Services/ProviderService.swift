//
//  Provider.swift
//  
//
//  Created by Nick Crews on 6/2/22.
//

import Foundation

struct ProviderService {
    private let address: String

    init(address: String) {
        self.address = address
    }

    func data(_ completion: @escaping (OBResult<[DataModel]>) -> Void) {

    }

    func payloads(_ completion: @escaping (OBResult<[Data]>) -> Void) {

    }
}
