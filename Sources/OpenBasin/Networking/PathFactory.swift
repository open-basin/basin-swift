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
            case dataset = "datastore/data/dataset"
            case payloads = "datastore/data/payloads"
        }
        enum Standards: String {
            case all = "datastore/standards/all/standards"
            case allSchemas = "datastore/standards/all/schemas"
            case standard = "datastore/standard/standard"
            case schema = "datastore/standard/schema"
            case data = "datastore/standard/data"
            case payloads = "datastore/standard/payloads"
            case standards = "datastore/standards/standards"
            case schemas = "datastore/standards/schemas"
            case standardsData = "datastore/standards/data"
            case standardsPayloads = "datastore/standards/payloads"
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
