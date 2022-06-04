//
//  StandardService.swift
//  
//
//  Created by Nick Crews on 6/1/22.
//

import Foundation

struct StandardService: AsyncService {
    var thread: DispatchQueue?
    private let token: Int
    private let remote = RemoteService.shared
    
    init(token: Int,
         thread: DispatchQueue? = nil) {
        self.token = token
        self.thread = thread
    }
    
    func receive(on thread: DispatchQueue) -> Self {
        StandardService(token: token, thread: thread)
    }
    
    func fetch(_ completion: @escaping (OBResult<StandardModel>) -> Void) {
        remote.fetch(StandardModel.self,
                     path: Path.Datastore.Standards.standard.rawValue,
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
    
    func schema(_ completion: @escaping (OBResult<Data>) -> Void) {
        remote.fetch(path: Path.Datastore.Standards.schema.rawValue,
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
    
    func data(_ completion: @escaping (OBResult<[DataModel]>) -> Void) {
        
        remote.fetch([DataModel].self,
                     path: Path.Datastore.Standards.data.rawValue,
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
    
    func payloads(_ completion: @escaping (OBResult<Data>) -> Void) {
        
        remote.fetch(path: Path.Datastore.Standards.payloads.rawValue,
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

struct StandardsService: AsyncService {
    var thread: DispatchQueue?
    private let tokens: [Int]
    private let remote = RemoteService.shared
    
    init(tokens: [Int],
         thread: DispatchQueue? = nil) {
        self.tokens = tokens
        self.thread = thread
    }
    
    func receive(on thread: DispatchQueue) -> Self {
        StandardsService(tokens: tokens, thread: thread)
    }
    
    func fetch(_ completion: @escaping (OBResult<[StandardResponse]>) -> Void) {
        
        remote.fetch([StandardResponse].self,
                     path: Path.Datastore.Standards.standards.rawValue,
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
    
    func schemas(_ completion: @escaping (OBResult<[SchemaResponse]>) -> Void) {
        
        remote.fetch([SchemaResponse].self,
                     path: Path.Datastore.Standards.schemas.rawValue,
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
    
    func data(_ completion: @escaping (OBResult<[DataResponse]>) -> Void) {
        
        remote.fetch([DataResponse].self,
                     path: Path.Datastore.Standards.standardsData.rawValue,
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
    
    func payloads(_ completion: @escaping (OBResult<[PayloadResponse]>) -> Void) {
        
        remote.fetch([PayloadResponse].self,
                     path: Path.Datastore.Standards.standardsPayloads.rawValue,
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
    
    struct StandardResponse: DatastoreModel {
        let token: Int
        let Standard: StandardModel
    }
    
    struct SchemaResponse: DatastoreModel {
        let token: Int
        let schema: Data
    }
    
    struct DataResponse: DatastoreModel {
        let token: Int
        let data: DataModel
    }
    
    struct PayloadResponse: DatastoreModel {
        let token: Int
        let payloads: Data
    }
}

struct AllStandardsService: AsyncService {
    let thread: DispatchQueue?
    private let remote = RemoteService.shared
    
    var all: AllStandards {
        AllStandards(thread: self.thread)
    }
    
    init(thread: DispatchQueue? = nil) {
        self.thread = thread
    }
    
    func receive(on thread: DispatchQueue) -> Self {
        AllStandardsService(thread: thread)
    }
    
    struct AllStandards: AsyncService {
        let thread: DispatchQueue?
        private let remote = RemoteService.shared
        
        init(thread: DispatchQueue? = nil) {
            self.thread = thread
        }
        
        func receive(on thread: DispatchQueue) -> Self {
            AllStandards(thread: thread)
        }
        
        func fetch(_ completion: @escaping (OBResult<[StandardModel]>) -> Void) {
            
            remote.fetch([StandardModel].self,
                         path: Path.Datastore.Standards.all.rawValue,
                         queryItems: [])
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
            
            remote.fetch(path: Path.Datastore.Standards.allSchemas.rawValue,
                         queryItems: [])
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
}
