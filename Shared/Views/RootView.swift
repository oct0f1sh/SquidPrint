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
    @State private var isPresentingAddPrinter: Bool = true
    var startingPage: Page = .home
    
    
    var body: some View {
        NavigationView {
            RootSidebar(printers: $printers, currentPrinter: $currentPrinter, isPresentingAddPrinter: $isPresentingAddPrinter)
            PrinterSidebar(printer: currentPrinter)
            PageHost(page: startingPage, printer: currentPrinter)
        }
        .navigationViewStyle(DoubleColumnNavigationViewStyle())
        .sheet(isPresented: $isPresentingAddPrinter) {
            AddPrinterView(handler: addPrinter)
        }
    }
    
    func addPrinter(_ url: String, _ apiKey: String) {
        
    }
}

struct AddPrinterView: View {
    @State private var printerURL: String = ""
    @State private var printerAPIKey: String = ""
    
    var handler: (_ url: String, _ apiKey: String) -> Void
    
    var body: some View {
        Text("New Printer").font(.title).padding(.top, 20)
        Form {
            Section {
                HStack {
                    Text("URL: ")
                    TextField("octopi.local", text: $printerURL)
                }
                HStack {
                    Text("API Key: ")
                    TextField("API KEY", text: $printerAPIKey)
                }
            }
        }
        
        Button(action: { handler(printerURL, printerAPIKey) }, label: {
            Text("Add printer")
        })
        .padding()
        .foregroundColor(.white)
        .background(Color.accentColor)
        .cornerRadius(10)
        .padding(.bottom, 10)
    }
}

struct RootSidebar: View {
    @Binding var printers: [Printer]
    @Binding var currentPrinter: Printer?
    @Binding var isPresentingAddPrinter: Bool
    
    var body: some View {
        List {
            ForEach(printers) { printer in
                NavigationLink(
                    destination: PrinterSidebar(printer: printer),
                    label: {
                        Label(printer.name, systemImage: "cube.box")
                    })
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
            RootView(printers: $printerStore.printers, currentPrinter: printerStore.printers.first, startingPage: .landing)
                .layoutLandscapeiPad()
        }
        
    }
}
