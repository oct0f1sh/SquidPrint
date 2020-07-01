//
//  SquidPrintApp.swift
//  Shared
//
//  Created by Duncan MacDonald on 6/26/20.
//

import SwiftUI

@main
struct SquidPrintApp: App {
     @StateObject private var connection = OctoPrintServer(
        using: NetworkManager(
            with: OctoPrintServerConfig(
                serverURL: URL(string: "10.0.0.90")!, apiKey: "DCCC957B0AEB469E8C4980319777D68D")))
    
    // App contains the Scene, and the Scene contains the Views
    var body: some Scene {
        WindowGroup {
            // Change this to pass in PrinterStore
            ContentView(server: connection)
        }
    }
}
