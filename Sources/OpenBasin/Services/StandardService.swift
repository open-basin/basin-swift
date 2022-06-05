//
//  StandardService.swift
//  
//
//  Created by Nick Crews on 6/1/22.
//

import Foundation

public struct StandardService: AsyncService {
    var thread: DispatchQueue?
    private let token: Int
    private let remote = RemoteService.shared
    
    init(token: Int,
         thread: DispatchQueue? = nil) {
        self.token = token
        self.thread = thread
    }
    
    public func receive(on thread: DispatchQueue) -> Self {
        StandardService(token: token, thread: thread)
    }
    
    public func fetch(_ completion: @escaping (OBResult<StandardModel>) -> Void) {
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
    
    public func schema(_ completion: @escaping (OBResult<Data>) -> Void) {
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
    
    public func data(_ completion: @escaping (OBResult<[DataModel]>) -> Void) {
        
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
    
    public func payloads(_ completion: @escaping (OBResult<[Data]>) -> Void) {
        
        remote.fetchSet(path: Path.Datastore.Standards.payloads.rawValue,
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

public struct StandardsService: AsyncService {
    var thread: DispatchQueue?
    private let tokens: [Int]
    private let remote = RemoteService.shared
    
    init(tokens: [Int],
         thread: DispatchQueue? = nil) {
        self.tokens = tokens
        self.thread = thread
    }
    
    public func receive(on thread: DispatchQueue) -> Self {
        StandardsService(tokens: tokens, thread: thread)
    }
    
    public func fetch(_ completion: @escaping (OBResult<[StandardSelfModel]>) -> Void) {
        
        remote.fetch([StandardSelfModel].self,
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
    
    public func schemas(_ completion: @escaping (OBResult<[StandardSchemaModel]>) -> Void) {
        
        remote.fetch([StandardSchemaModel].self,
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
    
    public func data(_ completion: @escaping (OBResult<[StandardDataModel]>) -> Void) {
        
        remote.fetch([StandardDataModel].self,
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
    
    public func payloads(_ completion: @escaping (OBResult<[StandardPayloadsModel]>) -> Void) {
        
        remote.fetch([StandardPayloadsModel].self,
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
}

public struct AllStandardsService: AsyncService {
    let thread: DispatchQueue?
    private let remote = RemoteService.shared
    
    var all: AllStandards {
        AllStandards(thread: self.thread)
    }
    
    init(thread: DispatchQueue? = nil) {
        self.thread = thread
    }
    
    public func receive(on thread: DispatchQueue) -> Self {
        AllStandardsService(thread: thread)
    }
    
    struct AllStandards: AsyncService {
        let thread: DispatchQueue?
        private let remote = RemoteService.shared
        
        init(thread: DispatchQueue? = nil) {
            self.thread = thread
        }
        
        public func receive(on thread: DispatchQueue) -> Self {
            AllStandards(thread: thread)
        }
        
        public func fetch(_ completion: @escaping (OBResult<[StandardModel]>) -> Void) {
            
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
        
        public func schemas(_ completion: @escaping (OBResult<[Data]>) -> Void) {
            
            remote.fetchSet(path: Path.Datastore.Standards.allSchemas.rawValue,
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
