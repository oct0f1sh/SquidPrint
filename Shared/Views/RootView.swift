//
//  RootView.swift
//  SquidPrint
//
//  Created by Duncan MacDonald on 7/7/20.
//

import SwiftUI

struct RootView: View {
    @ObservedObject var printerStore: PrinterStore
    @State var currentPrinter: Printer?
    @State private var isPresentingAddPrinter: Bool = false
    var startingPage: Page = .home
    
    var body: some View {
        NavigationView {
            RootSidebar(printerStore: printerStore, currentPrinter: $currentPrinter, isPresentingAddPrinter: $isPresentingAddPrinter)
            PrinterSidebar(printer: currentPrinter)
            PageHost(page: startingPage, printer: currentPrinter)
        }
        .navigationViewStyle(DoubleColumnNavigationViewStyle())
        .sheet(isPresented: $isPresentingAddPrinter) {
            AddPrinterView(handler: addPrinter)
        }
    }
    
    func addPrinter(_ name: String, _ stringUrl: String, _ apiKey: String) {
        guard let url = URL(string: stringUrl) else { return }
        
        let apiConfig = ServerConfiguration(url: url, apiKey: apiKey)
        let networkManager = NetworkClient(with: apiConfig)
        let printer = Printer(name, using: networkManager)
        
        printerStore.addPrinter(printer)
        
        isPresentingAddPrinter = false
    }
}

struct RootSidebar: View {
    @ObservedObject var printerStore: PrinterStore
    @Binding var currentPrinter: Printer?
    @Binding var isPresentingAddPrinter: Bool
    
    var body: some View {
        List {
            ForEach(printerStore.printers) { printer in
                NavigationLink(
                    destination: PrinterSidebar(printer: printer),
                    label: {
                        Label(printer.name, systemImage: "cube.box")
                    })
            }
            .onDelete { indexSet in
                printerStore.deletePrinter(atOffsets: indexSet)
            }
            
            Button(action: {
                isPresentingAddPrinter = true
            }, label: {
                Label("Add a printer...", systemImage: "plus")
            })
            .foregroundColor(.blue)
            .buttonStyle(BorderlessButtonStyle())
        }
        .padding(.leading, 1.0)
        .listStyle(SidebarListStyle())
        .navigationTitle("3D Printers")
    }
}

struct RootView_Previews: PreviewProvider {
    @StateObject static var printerStore = PrinterStore(mockData: true)
    
    static var previews: some View {
        Group {
            RootView(printerStore: printerStore, currentPrinter: printerStore.printers.first, startingPage: .landing)
                .layoutLandscapeiPad()
        }
    }
}
