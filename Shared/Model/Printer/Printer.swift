//
//  Printer.swift
//  SquidPrint
//
//  Created by Duncan MacDonald on 7/6/20.
//

import Foundation

class Printer: Identifiable, ObservableObject {
    // Published means that a notification will be sent whenever the object is changed
    @Published var name: String
    
    @Published var connectionController: ConnectionController
    var connection: Connection? {
        get { connectionController.connection }
    }
    
    var id: String {
        get { name }
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
