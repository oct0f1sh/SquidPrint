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
        Form {
            Section {
                HStack {
                    Spacer()
                    Text("Connection: \(connection?.state ?? "none")")
//                    Image(systemName: connected ? "wifi" : "wifi.slash")
                    Spacer()
                }
            }
        }
    }
}

struct ConnectionPage_Previews: PreviewProvider {
    @StateObject static var printerStore = PrinterStore(mockData: true)
    
    static var previews: some View {
        RootView(printers: $printerStore.printers, currentPrinter: printerStore.printers.first!, selectedPage: .connection)
            .layoutLandscapeiPad()
    }
}
