//
//  HomePage.swift
//  SquidPrint
//
//  Created by Duncan MacDonald on 7/18/20.
//

import SwiftUI

struct HomePage: View {
    @ObservedObject var connectionController: ConnectionController
    
    var fallbackValue = "Unknown"
    
    var body: some View {
        VStack {
            Form {
                ConnectionPageCell(title: "Printer State",
                                   value: connectionController.connection?.state ?? fallbackValue)
                
                Section {
                    ConnectionPageCell(title: "File Name", value: fallbackValue)
                    ConnectionPageCell(title: "Upload Date", value: fallbackValue)
                    ConnectionPageCell(title: "User", value: fallbackValue)
                }
                
                Section(footer: StateFormFooter().padding(.top, 10)) {
                        ConnectionPageCell(title: "Current Print Time", value: fallbackValue)
                        ConnectionPageCell(title: "Remaining Print Time", value: fallbackValue)
                        ConnectionPageCell(title: "Percent Done", value: fallbackValue)
                }
            }
        }
        .navigationTitle("State")
    }
}

struct StateFormFooter: View {
    var body: some View {
        HStack {
            Spacer()
            Button(action: {}, label: {
                Label("Pause", systemImage: "pause")
                    .font(.callout)
                    .frame(minWidth: 100)
                    .padding()
                    .foregroundColor(Color.buttonForeground)
                    .background(Color.accentColor)
                    .cornerRadius(10)
            })

            Button(action: {}, label: {
                Label("Cancel", systemImage: "stop.fill")
                    .font(.callout)
                    .frame(minWidth: 100)
                    .padding()
                    .foregroundColor(Color.buttonForeground)
                    .background(Color.accentColor)
                    .cornerRadius(10)
            })
            Spacer()
        }
    }
}

struct HomePage_Previews: PreviewProvider {
    @StateObject static var printerStore = PrinterStore(mockData: true)
    
    static var previews: some View {
        RootView(printerStore: printerStore, currentPrinter: printerStore.printers.first!, startingPage: .home)
            .preferredColorScheme(.dark)
            .layoutLandscapeiPad()
        HomePage(connectionController: printerStore.printers[0].connectionController)
            .previewDevice("iPad (7th generation)")
    }
}
