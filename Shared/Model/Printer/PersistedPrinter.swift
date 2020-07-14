//
//  PersistedPrinter.swift
//  SquidPrint
//
//  Created by Duncan MacDonald on 7/12/20.
//

import Foundation
import SwiftUI
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

enum PrinterDocumentError: Error {
    case decodingError(String)
}

struct PersistedPrinterDocument: FileDocument {
    let persistedPrinter: PersistedPrinter
    
    static var readableContentTypes: [UTType] = [.json]
    
    init(persistedPrinter: PersistedPrinter) {
        self.persistedPrinter = persistedPrinter
    }
    
    init(for printer: Printer) {
        self.persistedPrinter = PersistedPrinter(for: printer)
    }
    
    init(fileWrapper: FileWrapper, contentType: UTType) throws {
        guard let data = fileWrapper.regularFileContents else {
            throw PrinterDocumentError.decodingError("Error decoding file: \(fileWrapper.filename ?? "nil")")
        }
        persistedPrinter = try JSONDecoder().decode(PersistedPrinter.self, from: data)
    }
    
    func write(to fileWrapper: inout FileWrapper, contentType: UTType) throws {
        let data = try JSONEncoder().encode(persistedPrinter)
        fileWrapper = FileWrapper(regularFileWithContents: data)
    }
}
