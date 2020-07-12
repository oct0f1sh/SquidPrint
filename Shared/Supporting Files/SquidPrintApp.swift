//
//  SquidPrintApp.swift
//  Shared
//
//  Created by Duncan MacDonald on 6/26/20.
//

import SwiftUI

@main
struct SquidPrintApp: App {
    @StateObject var printerStore = PrinterStore(mockData: true)
    
    var body: some Scene {
        WindowGroup {
            RootView(printers: $printerStore.printers, currentPrinter: printerStore.printers.first)
        }
    }
}
