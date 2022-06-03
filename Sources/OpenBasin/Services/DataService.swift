//
//  DataService.swift
//  
//
//  Created by Nick Crews on 6/1/22.
//

import Foundation

struct DataService {
    private let token: Int

    init(token: Int) {
        self.token = token
    }

    func fetch(_ completion: @escaping (OBResult<String>) -> Void) {
        
    }

    func payload(_ completion: @escaping (OBResult<String>) -> Void) {

    }
}

struct DatasService {
    private let tokens: Set<Int>

    init(tokens: Set<Int>) {
        self.tokens = tokens
    }

    func fetch(_ completion: @escaping (OBResult<[Int: DataModel]>) -> Void) {

    }

    func payloads(_ completion: @escaping (OBResult<[Int: String]>) -> Void) {

    }
}
