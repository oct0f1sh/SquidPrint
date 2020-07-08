//
//  RootView.swift
//  SquidPrint
//
//  Created by Duncan MacDonald on 7/7/20.
//

import SwiftUI

struct RootView: View {
    @State var printers: [Printer]
    
    var body: some View {
        List {
            ForEach(printers) { printer in
                Text("what up")
            }
        }
    }
}

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        RootView(printers: [Printer("a printer", with: ConnectionController(using: FakeConnectionDataSource()))])
    }
}
