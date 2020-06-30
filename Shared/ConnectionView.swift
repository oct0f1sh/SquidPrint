//
//  ConnectionView.swift
//  SquidPrint
//
//  Created by Duncan MacDonald on 6/28/20.
//

import SwiftUI

struct ConnectionView: View {
    @State var connected: Bool = false
    
    var body: some View {
        Form {
            Section {
                HStack {
                    Spacer()
                    Text("Connection: ")
                    Image(systemName: connected ? "wifi" : "wifi.slash")
                    Spacer()
                }
                HStack {
                    Spacer()
                    Button(connected ? "Disconnect" : "Connect") {
                        print("doing the thing")
                    }
                    Spacer()
                }
            }
        }
    }
}

struct ConnectionView_Previews: PreviewProvider {
    static var previews: some View {
        ConnectionView()
    }
}
