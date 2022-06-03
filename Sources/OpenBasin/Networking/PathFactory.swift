//
//  PathFactory.swift
//  
//
//  Created by Nick Crews on 6/3/22.
//

import Foundation



enum Path {
    enum Datastore {
        enum Owner: String {
            case data = "datastore/owner/data"
            case payloads = "datastore/owner/payloads"

            enum Standard: String {
                case data = "datastore/owner/standard/data"
                case payloads = "datastore/owner/standard/payloads"
            }
        }
        enum Data: String {
            case data = "datastore/data/data"
            case payload = "datastore/data/payload"
        }
        enum Standards: String {
            case all = "datastore/standards/all"
            case schemas = "datastore/standards/schemas"
            case standard = "datastore/standards/standard"
            case schema = "datastore/standards/schema"
            case data = "datastore/standards/data"
            case payloads = "datastore/standards/payloads"
        }
        enum Provider: String {
            case data = "datastore/provider/data"
            case payloads = "datastore/provider/payloads"
        }
        enum Minter: String {
            case standards = "datastore/minter/standards"
            case schemas = "datastore/minter/schemas"
        }
    }
}
