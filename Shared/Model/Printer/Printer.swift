//
//  Printer.swift
//  SquidPrint
//
//  Created by Duncan MacDonald on 7/6/20.
//

import Foundation

struct Printer {
    private var connectionController: ConnectionController
    var connection: Connection? {
        get { connectionController.connection }
    }
    
    init(using networkManager: NetworkManager) {
        self.connectionController = RemoteConnectionController(using: networkManager)
    }
    
    func update() {
        connectionController.update()
    }
}
