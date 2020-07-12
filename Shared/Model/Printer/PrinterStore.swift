//
//  PrinterStore.swift
//  SquidPrint
//
//  Created by Duncan MacDonald on 7/11/20.
//

import Foundation

class PrinterStore: ObservableObject {
    @Published var printers: [Printer] = []
    
    init(mockData: Bool = false) {
        if mockData {
            let networkClient = NetworkClient(with: ServerConfiguration(url: URL(staticString: "google.com"), apiKey: "12345"))
            let connectionController = ConnectionController(using: FakeConnectionDataSource())
            
            printers = [
                Printer("Prusa i3 Mk3", with: connectionController, using: networkClient),
                Printer("Prusa i3 Mk3", with: connectionController, using: networkClient),
                Printer("Ender 3", with: connectionController, using: networkClient)
            ]
        }
    }
}
