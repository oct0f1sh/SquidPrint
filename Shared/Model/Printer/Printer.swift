//
//  Printer.swift
//  SquidPrint
//
//  Created by Duncan MacDonald on 7/6/20.
//

import Foundation

class Printer: Identifiable, ObservableObject {
    @Published var name: String
    var id: String {
        get { name }
    }
    
    @Published var connectionController: ConnectionController
    var connection: Connection? {
        get { connectionController.connection }
    }
    
    init(_ name: String, using networkManager: NetworkManager) {
        self.name = name
        self.connectionController = ConnectionController(using: RemoteConnectionDataSource(using: networkManager))
    }
    
    init(_ name: String, with connectionController: ConnectionController) {
        self.name = name
        self.connectionController = connectionController
    }
    
    func update() {
        connectionController.update()
    }
}
