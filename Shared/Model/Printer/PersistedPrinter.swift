//
//  PersistedPrinter.swift
//  SquidPrint
//
//  Created by Duncan MacDonald on 7/12/20.
//

import Foundation
import UniformTypeIdentifiers

struct PersistedPrinter: Codable {
    let url: URL
    let apiKey: String
    let name: String
    let uuid: UUID
    
    init(for printer: Printer) {
        self.url = printer.networkClient.serverConfig.url
        self.apiKey = printer.networkClient.serverConfig.apiKey
        self.name = printer.name
        self.uuid = printer.uuid
    }
}
