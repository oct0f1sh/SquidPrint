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
    @State var selectedPage: Page
    
    var body: some View {
        NavigationView {
            RootSidebar(printers: $printers, currentPrinter: $currentPrinter)
            PrinterSidebar(printer: currentPrinter, selectedPage: $selectedPage)
            PageHost(page: selectedPage, printer: currentPrinter)
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
                Button(action: {
                    currentPrinter = printer
                }, label: {
                    Label(printer.name, systemImage: "cube.box.fill")
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
        .navigationTitle("SquidPrint")
    }
    
    func addPrinter() {
        print("add a printer")
    }
}

struct RootView_Previews: PreviewProvider {
    @StateObject static var printerStore = PrinterStore(mockData: true)
    
    static var previews: some View {
        RootView(printers: $printerStore.printers, currentPrinter: printerStore.printers.first, selectedPage: .landing)
            .layoutLandscapeiPad()
    }
}
