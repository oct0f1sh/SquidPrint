//
//  PrinterSidebar.swift
//  Shared
//
//  Created by Duncan MacDonald on 6/26/20.
//

import SwiftUI

struct PrinterSidebar: View {
    @State var printer: Printer?
    
    private let pages: [Page] = [.home, .connection, .files]
    
    var body: some View {
        VStack {
            if let printer = printer {
                List(pages, id: \.self) { page in
                    NavigationLink(
                        destination: PageHost(page: page, printer: printer),
                        label: {
                            Label(page.rawValue.capitalized, systemImage: page.thumbnail)
                        })
                }
                .navigationTitle(printer.name)
                .listStyle(SidebarListStyle())
            } else {
                // printer will only be nil if using a split view and the user hasn't
                // selected a printer yet. In that situation we don't want to show the
                // printer column.
                Text("Please add a printer")
            }
        }
    }
}

struct PrinterSidebar_Previews: PreviewProvider {
    @StateObject static var printerStore = PrinterStore(mockData: true)
    
    static var previews: some View {
        RootView(printers: $printerStore.printers, currentPrinter: printerStore.printers.first, startingPage: .landing)
            .layoutLandscapeiPad()
    }
}
