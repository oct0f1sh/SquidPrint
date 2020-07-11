//
//  PrinterView.swift
//  Shared
//
//  Created by Duncan MacDonald on 6/26/20.
//

import SwiftUI

struct PrinterSidebar: View {
    @Binding var printer: Printer?
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
                if let printer = printer {
                    NavigationLink(
                        destination: ConnectionView(connectionController: printer.connectionController),
                        label: { Label(page, systemImage: "wifi") }
                    ).disabled(true)
                } else {
                    Button(action: { print("nice") }, label: { Label(page, systemImage: "wifi") })
                }
            default:
                Text("Something weird happened")
            }
        }
        .navigationTitle(printer?.name ?? "Printer")
        .listStyle(SidebarListStyle())
    }
}

struct ContentView_Previews: PreviewProvider {
    @State static var printer: Printer? = Printer("printer", with: ConnectionController(using: FakeConnectionDataSource()))
    
    static var previews: some View {
        return PrinterSidebar(printer: $printer)
    }
}
