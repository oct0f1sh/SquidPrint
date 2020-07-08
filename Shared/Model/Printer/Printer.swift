//
//  Printer.swift
//  SquidPrint
//
//  Created by Duncan MacDonald on 7/6/20.
//

import Foundation

struct Printer {
    var connectionController: ConnectionController
    var connection: Connection? {
        get { connectionController.connection }
    }
    
    init(using networkManager: NetworkManager) {
        self.connectionController = ConnectionController(using: RemoteConnectionDataSource(using: networkManager))
    }
    
    init(with connectionController: ConnectionController) {
        self.connectionController = connectionController
    }
    
    func update() {
        connectionController.update()
    }
}
