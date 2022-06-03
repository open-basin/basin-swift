//
//  MinterService.swift
//  
//
//  Created by Nick Crews on 6/2/22.
//

import Foundation

struct MinterService {
    private let address: String

    init(address: String) {
        self.address = address
    }

    func standards(_ completion: @escaping (OBResult<[StandardModel]>) -> Void) {

    }

    func schemas(_ completion: @escaping (OBResult<Data>) -> Void) {

    }
}
