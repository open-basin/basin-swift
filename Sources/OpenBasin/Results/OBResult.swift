//
//  File.swift
//  
//
//  Created by Nick Crews on 6/1/22.
//

import Foundation

public enum OBResult<Element> {
    case success(_ value: Element)
    case error(_ value: ResultError)
}
