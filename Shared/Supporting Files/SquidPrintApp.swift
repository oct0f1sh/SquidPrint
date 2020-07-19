//
//  SquidPrintApp.swift
//  Shared
//
//  Created by Duncan MacDonald on 6/26/20.
//

import SwiftUI

@main
struct SquidPrintApp: App {
    @StateObject var printerStore = PrinterStore(mockData: true, skipFetchPrinters: false)
    
    var body: some Scene {
        WindowGroup {
            RootView(printerStore: printerStore, currentPrinter: printerStore.printers.first)
        }
    }
}
