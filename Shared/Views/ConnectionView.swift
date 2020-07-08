//
//  ConnectionView.swift
//  SquidPrint
//
//  Created by Duncan MacDonald on 6/28/20.
//

import SwiftUI

struct ConnectionView: View {
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
                HStack {
                    Spacer()
                    Text("placeholder")
//                    Button(connected ? "Disconnect" : "Connect") {
//                        print("doing the thing")
//                    }
                    Spacer()
                }
            }
        }
    }
}

//struct ConnectionView_Previews: PreviewProvider {
//    static var previews: some View {
//        ConnectionView(connectionController: ConnectionController(for: ))
//    }
//}
