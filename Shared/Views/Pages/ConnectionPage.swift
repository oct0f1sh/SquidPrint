//
//  ConnectionPage.swift
//  SquidPrint
//
//  Created by Duncan MacDonald on 6/28/20.
//

import SwiftUI

struct ConnectionPage: View {
    @ObservedObject var connectionController: ConnectionController
    
    private var connection: Connection? {
        get { connectionController.connection }
    }
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                Form {
                    ConnectionPageCell(title: "Serial Port", value: "/dev/ttyACM0")
                    ConnectionPageCell(title: "Baudrate", value: "115200")
                    ConnectionPageCell(title: "Printer Profile", value: "Prusa i3 Mk3")
                    
                    Section {
                        Toggle(isOn: .constant(true), label: {
                            Text("Save connection settings")
                        })
                        
                        Toggle(isOn: .constant(true), label: {
                            Text("Auto-connect on server startup")
                        })
                    }
                    
                    HStack {
                        Spacer()
                        Button(action: {}, label: {
                            Label("Disconnect", systemImage: "wifi.slash")
                        })
                        Spacer()
                    }
                }
                .listStyle(PlainListStyle())
                .navigationTitle("Connection")
            }
        }
    }
}

struct ConnectionPageCell: View {
    var title: String
    var value: String
    
    var body: some View {
        HStack {
            Text(title).fontWeight(.bold)
            Spacer()
            Text(value).fontWeight(.light).foregroundColor(Color(.secondaryLabel))
        }
    }
}

struct ConnectionPage_Previews: PreviewProvider {
    @StateObject static var printerStore = PrinterStore(mockData: true)
    
    static var previews: some View {
        Group {
            RootView(printerStore: printerStore, currentPrinter: printerStore.printers.first!, startingPage: .connection)
                .preferredColorScheme(.dark)
                .layoutLandscapeiPad()
            ConnectionPage(connectionController: printerStore.printers[0].connectionController)
                .previewDevice("iPhone 11")
                .preferredColorScheme(.dark)
        }
    }
}
