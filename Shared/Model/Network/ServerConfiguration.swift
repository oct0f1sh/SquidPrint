//
//  ServerConfiguration.swift
//  SquidPrint
//
//  Created by Duncan MacDonald on 7/12/20.
//

import Foundation

struct ServerConfiguration: Codable, Equatable {
    let url: URL
    let apiKey: String
}
