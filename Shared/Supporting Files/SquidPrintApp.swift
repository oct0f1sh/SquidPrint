//
//  SquidPrintApp.swift
//  Shared
//
//  Created by Duncan MacDonald on 6/26/20.
//

import SwiftUI

@main
struct SquidPrintApp: App {
//    @StateObject let printerStore
    // @SceneStorage currentPrinterID
    // Persist list of printerIDs
    let apiConfig = OctoPrintAPIConfig(serverURL: "example.com", apiKey: "A KEY")
    
    var body: some Scene {
        WindowGroup {
            RootView(printers: [
                Printer("Prusa i3 Mk3", with: ConnectionController(using: FakeConnectionDataSource())),
                Printer("Ender 3", with: ConnectionController(using: FakeConnectionDataSource())),
            ], currentPrinter: Printer("Prusa i3 Mk3", with: ConnectionController(using: FakeConnectionDataSource())))
        }
    }
}
