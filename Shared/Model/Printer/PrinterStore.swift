//
//  PrinterStore.swift
//  SquidPrint
//
//  Created by Duncan MacDonald on 7/11/20.
//

import Foundation

/// A local source of printers. When initialized, `PrinterStore` checks the default document directory for `PersistedPrinterDocuments` that are used to populate `printers`.
class PrinterStore: ObservableObject {
    @Published var printers: [Printer] = []
    
    /// Helper to get the default documents directory
    lazy var documentsURL: URL = {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentsDirectory = paths[0]
        return documentsDirectory
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
        fetchPrinters(from: documentsURL)
    }
    
    func updatePrinterList() {
        fetchPrinters(from: documentsURL)
    }
    
    /// Update `printers` from a local directory
    /// - Parameter directory: The URL for the directory to check
    private func fetchPrinters(from directory: URL) {
        do {
            let files = try FileManager.default.contentsOfDirectory(atPath: directory.path)
            let decoder = JSONDecoder()
            
            for file in files {
                let fileFullURL = directory.appendingPathComponent(file)
                let fileData = try Data(contentsOf: fileFullURL)
                
                let persistedPrinter = try decoder.decode(PersistedPrinter.self, from: fileData)
                printers.append(Printer(from: persistedPrinter))
            }
        } catch let error {
            print("Error creating wrapper for documents URL: \(error.localizedDescription)")
        }
    }
    
    func saveAllPrinters() {
        persistPrinters(to: documentsURL)
    }
    
    private func persistPrinters(to directory: URL) {
        let encoder = JSONEncoder()
        
        for printer in printers {
            do {
                let persistedPrinter = PersistedPrinter(for: printer)
                let fileURL = directory.appendingPathComponent(printer.uuid.uuidString).appendingPathExtension(for: .json)
                let data = try encoder.encode(persistedPrinter)
                FileManager.default.createFile(atPath: fileURL.path, contents: data)
                print("Saved printer to path: \(fileURL.absoluteString)")
            } catch let error {
                print("Error persisting printers to directory: \(error.localizedDescription)")
            }
        }
    }
}
