//
//  PrinterStore.swift
//  SquidPrint
//
//  Created by Duncan MacDonald on 7/11/20.
//

import Foundation

/// A local source of printers. When initialized, `PrinterStore` checks the default document directory for `PersistedPrinterDocuments` that are used to populate `printers`.
class PrinterStore: ObservableObject {
    @Published private(set) var printers: [Printer] = []
    
    /// Helper to get the URL of the persisted printer file in the documents directory
    lazy var printersURL: URL = {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentsDirectory = paths[0]
        return documentsDirectory.appendingPathComponent("PersistedPrinters.json")
    }()
    
    /// Initialize a PrinterStore with mock data. Useful for using in SwiftUI previews
    /// - Parameter mockData: whether or not to populate `printers` with fake data
    /// - Parameter skipFetchPrinters: whether or not to fetch printers from documents directory on initialization
    init(mockData: Bool = false, skipFetchPrinters: Bool = false) {
        if mockData {
            let networkClient = NetworkClient(with: ServerConfiguration(url: URL(staticString: "google.com"), apiKey: "12345"))
            let connectionController = ConnectionController(using: FakeConnectionDataSource())
            
            printers = [
                Printer("Prusa i3 Mk3", with: connectionController, using: networkClient),
                Printer("Ender 3", with: connectionController, using: networkClient)
            ]
        }
        if !skipFetchPrinters {
            updatePrinterList()
        }
    }
    
    /// Create a PrinterStore using the default documents directory
    init() {
        fetchPrinters(from: printersURL)
    }
    
    func updatePrinterList() {
        fetchPrinters(from: printersURL)
    }
    
    /// Update `printers` from a local file
    /// - Parameter directory: The URL for the file to check
    private func fetchPrinters(from file: URL) {
        do {
            let printerData = try Data(contentsOf: printersURL)
            let persistedPrinters = try JSONDecoder().decode([PersistedPrinter].self, from: printerData)
            
            printers = persistedPrinters.compactMap { Printer(from: $0) }
            print("Decoded \(printers.count) printers from file: \(file.path)")
        } catch let error {
            print("Error creating wrapper for documents URL: \(error.localizedDescription)")
        }
    }
    
    func saveAllPrinters() {
        persistPrinters(to: printersURL)
    }
    
    private func persistPrinters(to file: URL) {
        let persistedPrinters = printers.compactMap { PersistedPrinter(for: $0) }
        
        do {
            let data = try JSONEncoder().encode(persistedPrinters)
            FileManager.default.createFile(atPath: file.path, contents: data)
            print("Persisted printers to file: \(file.path)")
        } catch let error {
            print("Error persisting printers to directory: \(error.localizedDescription)")
        }
    }
    
    func addPrinter(_ printer: Printer) {
        printers.append(printer)
        saveAllPrinters()
    }
    
    func deletePrinter(atOffsets: IndexSet) {
        printers.remove(atOffsets: atOffsets)
        saveAllPrinters()
    }
}
