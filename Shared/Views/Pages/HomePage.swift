//
//  HomePage.swift
//  SquidPrint
//
//  Created by Duncan MacDonald on 7/18/20.
//

import SwiftUI

struct HomePage: View {
    var printer: Printer
    
    var body: some View {
        VStack {
            Form {
                ConnectionPageCell(title: "Printer State", value: "Printing...")
                
                Section {
                    ConnectionPageCell(title: "File Name", value: "buddy.gcode")
                    ConnectionPageCell(title: "Upload Date", value: "01-01-2020")
                    ConnectionPageCell(title: "User", value: "API User")
                }
                
                Section(footer: StateFormFooter().padding(.top, 10)) {
                        ConnectionPageCell(title: "Current Print Time", value: "05:25:30")
                        ConnectionPageCell(title: "Remaining Print Time", value: "01:15:00")
                        ConnectionPageCell(title: "Percent Done", value: "80%")
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
        HomePage(printer: printerStore.printers[0])
            .previewDevice("iPad (7th generation)")
    }
}
