//
//  PrinterStore.swift
//  SquidPrint
//
//  Created by Duncan MacDonald on 7/11/20.
//

import Foundation

class PrinterStore: ObservableObject {
    @Published var printers: [Printer] = []
    
    init(mockData: Bool = false) {
        if mockData {
            printers = [
                Printer("Prusa i3 Mk3", with: ConnectionController(using: FakeConnectionDataSource())),
                Printer("Ender 3", with: ConnectionController(using: FakeConnectionDataSource()))
            ]
        }
    }
}
