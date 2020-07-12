//
//  RootView.swift
//  SquidPrint
//
//  Created by Duncan MacDonald on 7/7/20.
//

import SwiftUI

struct RootView: View {
    @Binding var printers: [Printer]
    @State var currentPrinter: Printer?
    var startingPage: Page = .home
    
    var body: some View {
        NavigationView {
            RootSidebar(printers: $printers, currentPrinter: $currentPrinter)
            PrinterSidebar(printer: currentPrinter)
            PageHost(page: startingPage, printer: currentPrinter)
        }
        .navigationViewStyle(DoubleColumnNavigationViewStyle())
    }
}

struct RootSidebar: View {
    @Binding var printers: [Printer]
    @Binding var currentPrinter: Printer?
    
    var body: some View {
        List {
            ForEach(printers) { printer in
                NavigationLink(
                    destination: PrinterSidebar(printer: printer),
                    label: {
                        Label(printer.name, systemImage: "cube.box")
                    })
            }
            
            Button(action: addPrinter, label: {
                Label("Add a printer...", systemImage: "plus")
            })
            .foregroundColor(.blue)
            .buttonStyle(BorderlessButtonStyle())
        }
        .padding(.leading, 1.0)
        .listStyle(SidebarListStyle())
        .navigationTitle("3D Printers")
    }
    
    func addPrinter() {
        print("add a printer")
    }
}

struct RootView_Previews: PreviewProvider {
    @StateObject static var printerStore = PrinterStore(mockData: true)
    
    static var previews: some View {
        Group {
            RootView(printers: $printerStore.printers, currentPrinter: printerStore.printers.first, startingPage: .landing)
                .layoutLandscapeiPad()
        }
        
    }
}
