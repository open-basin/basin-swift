//
//  AsyncService.swift
//  
//
//  Created by Nick Crews on 6/3/22.
//

import Foundation

protocol AsyncService {
    var thread: DispatchQueue? { get }

    func receive(on thread: DispatchQueue) -> Self
}
