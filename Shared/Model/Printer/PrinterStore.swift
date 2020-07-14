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
    /// - Parameter mockData: whether or not to use mock data
    init(mockData: Bool = false) {
        if mockData {
            let networkClient = NetworkClient(with: ServerConfiguration(url: URL(staticString: "google.com"), apiKey: "12345"))
            let connectionController = ConnectionController(using: FakeConnectionDataSource())
            
            printers = [
                Printer("Prusa i3 Mk3", with: connectionController, using: networkClient),
                Printer("Prusa i3 Mk3", with: connectionController, using: networkClient),
                Printer("Ender 3", with: connectionController, using: networkClient)
            ]
        } else {
            fetchPrinters(from: documentsURL)
        }
    }
    
    /// Create a PrinterStore using the default documents directory
    init() {
        fetchPrinters(from: documentsURL)
    }
    
    /// Update `printers` from a local directory
    /// - Parameter directory: The URL for the directory to check
    func fetchPrinters(from directory: URL) {
        do {
            let directoryWrapper = try FileWrapper(url: directory, options: .immediate)
            
            directoryWrapper.fileWrappers?.forEach({ fileName, fileWrapper in
                if let persistedPrinterDocument = try? PersistedPrinterDocument(fileWrapper: fileWrapper, contentType: .json) {
                    self.printers.append(Printer(from: persistedPrinterDocument.persistedPrinter))
                } else {
                    print("Could not create PersistedPrinterDocument from FileWrapper")
                }
            })
        } catch let error {
            print("Error creating wrapper for documents URL: \(error.localizedDescription)")
        }
    }
}
