//
//  PrinterView.swift
//  Shared
//
//  Created by Duncan MacDonald on 6/26/20.
//

import SwiftUI

struct PrinterView: View {
    var printer: Printer
    
    var body: some View {
        NavigationView {
            Sidebar(printer: printer)
            ConnectionView(connectionController: printer.connectionController)
        }
    }
}

struct Sidebar: View {
    var printer: Printer
    let pages: [String] = ["Home", "Connection"]
    
    var body: some View {
        List(pages, id: \.self) { page in
            switch page {
            case "Home":
                NavigationLink(
                    destination: LandingPage(title: "landing page"),
                    label: { Label(page, systemImage: "house") }
                )
            case "Connection":
                NavigationLink(
                    destination: ConnectionView(connectionController: printer.connectionController),
                    label: { Label(page, systemImage: "wifi") }
                )
            default:
                Text("Something weird happened")
            }
        }
        .navigationTitle("SquidPrint")
        .listStyle(SidebarListStyle())
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let printer = Printer(with: ConnectionController(using: FakeConnectionDataSource()))
        
        return PrinterView(printer: printer)
            .preferredColorScheme(.dark)
    }
}
