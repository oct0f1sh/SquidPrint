//
//  SquidPrintApp.swift
//  Shared
//
//  Created by Duncan MacDonald on 6/26/20.
//

import SwiftUI

@main
struct SquidPrintApp: App {
    let apiConfig = OctoPrintAPIConfig(serverURL: "example.com", apiKey: "A KEY")
    
    var body: some Scene {
        WindowGroup {
            PrinterView(printer: Printer(using: NetworkManager(with: apiConfig)))
        }
    }
}
