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
            List {
                ConnectionPageCell(title: "Serial Port", value: "/dev/ttyACM0")
                ConnectionPageCell(title: "Baudrate", value: "115200")
                ConnectionPageCell(title: "Printer Profile", value: "Prusa i3 Mk3")
                
//                HStack {
//                    Button(action: {}, label: {
//                        Image(systemName: "play.fill")
//                            .padding(.vertical, 15)
//                            .padding(.horizontal, 350 / 4 - 20)
//                    })
//                    .background(Color(.secondarySystemBackground))
//                    .cornerRadius(10)
//
//                    Button(action: {}, label: {
//                        Image(systemName: "pause.fill")
//                            .padding(.vertical, 15)
//                            .padding(.horizontal, 350 / 4 - 20)
//                    })
//                    .background(Color(.secondarySystemBackground))
//                    .cornerRadius(10)
//                }
//                .frame(width: 350)
            }
            .listStyle(PlainListStyle())
            .navigationTitle("Connection")
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
            Text(value).fontWeight(.light).foregroundColor(Color(.systemGray))
        }
        .frame(width: 350)
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
                .preferredColorScheme(.dark)
        }
    }
}
