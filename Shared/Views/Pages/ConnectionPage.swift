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
    
    let fallbackValue: String = "Disconnected"
    
    var isConnected: Bool {
        connection != nil
    }
    
    var body: some View {
        Form {
            ConnectionPageCell(title: "Serial Port",
                               value: connection?.port ?? fallbackValue)
            
            ConnectionPageCell(title: "Baudrate",
                               value: connection?.baudrate.description ?? fallbackValue)
            
            ConnectionPageCell(title: "Printer Profile",
                               value: connection?.printerProfileID ?? fallbackValue)
            
            Section {
                Toggle(isOn: .constant(false), label: {
                    Text("Save connection settings")
                })
                .disabled(true) //!isConnected)
                
                Toggle(isOn: .constant(false), label: {
                    Text("Auto-connect on server startup")
                })
                .disabled(true) //!isConnected)
            }
            
            HStack {
                Spacer()
                Button(action: {}, label: {
                    Label((connection == nil ? "Connect" : "Disconnect"), systemImage: connection == nil ? "wifi" : "wifi.slash")
                })
                Spacer()
            }
        }
        .navigationTitle("Connection")
    }
}

struct ConnectionPageCell: View {
    var title: String
    var value: String
    
    var body: some View {
        HStack {
            Text(title)
            Spacer()
            Text(value).fontWeight(.light).foregroundColor(Color(.secondaryLabelColor))
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
            ConnectionPage(connectionController: ConnectionController(using: NilConnectionDataSource()))
                .previewDevice("iPad (7th generation)")
                .preferredColorScheme(.dark)
            ConnectionPage(connectionController: printerStore.printers[0].connectionController)
                .previewDevice("iPhone 11")
                .preferredColorScheme(.dark)
        }
    }
}
