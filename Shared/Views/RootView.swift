//
//  RootView.swift
//  SquidPrint
//
//  Created by Duncan MacDonald on 7/7/20.
//

import SwiftUI

struct RootView: View {
    @State var printers: [Printer]
    @State var currentPrinter: Printer?
    
    var body: some View {
        NavigationView {
            RootSidebar(printers: printers, currentPrinter: $currentPrinter)
            if let _ = currentPrinter {
                PrinterSidebar(printer: $currentPrinter)
            } else {
                /*@START_MENU_TOKEN@*/EmptyView()/*@END_MENU_TOKEN@*/
            }
            LandingPage(title: "Welcome")
        }
        .navigationViewStyle(DoubleColumnNavigationViewStyle())
    }
}

struct RootSidebar: View {
    @State var printers: [Printer]
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
    static var previews: some View {
        Group {
            RootView(printers: [Printer("a printer", with: ConnectionController(using: FakeConnectionDataSource()))])
                .previewDevice("iPhone 11")
            RootView(printers: [Printer("a printer", with: ConnectionController(using: FakeConnectionDataSource()))])
                .previewLayout(.fixed(width: 1024.0, height: 768.0))
                .previewDevice("iPad (7th generation)")
        }
    }
}
