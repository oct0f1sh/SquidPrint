//
//  SquidPrintApp.swift
//  Shared
//
//  Created by Duncan MacDonald on 6/26/20.
//

import SwiftUI

@main
struct SquidPrintApp: App {
    @StateObject var printerStore = PrinterStore()
    
    var body: some Scene {
        WindowGroup {
            RootView(printers: $printerStore.printers, currentPrinter: printerStore.printers.first, selectedPage: .landing)
        }
    }
}

class PrinterStore: ObservableObject {
    @Published var printers: [Printer] = []
    
    init(mockData: Bool = false) {
        if mockData {
            printers = [
                Printer("Prusa i3 Mk3", with: ConnectionController(using: FakeConnectionDataSource())),
                Printer("Ender 3", with: ConnectionController(using: FakeConnectionDataSource()))
            ]
        }
    }
}
